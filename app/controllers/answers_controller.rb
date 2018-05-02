class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:update, :destroy, :best]

  after_action :publish_answer, only: :create


  respond_to :js
  respond_to :json, only: :create


  include Voted

  authorize_resource

 
  def new
    @answer = Answer.new
  end


  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(user: current_user))
    respond_with @answer
  end

  def destroy
    respond_with(@answer.destroy) if current_user.author?(@answer)
  end


  def update
    @answer.update(answer_params)
    respond_with @answer 
  end


  def best
    @answer.set_best if current_user.author?(@answer.question)
  end


  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = current_user.answers.find(params[:id])
    @question = @answer.question
  end

  def publish_answer
     return if @answer.errors.any?
     ActionCable.server.broadcast "questions/#{@answer.question.id}/answers", answer: @answer.to_json if @answer.valid?
  end
end
