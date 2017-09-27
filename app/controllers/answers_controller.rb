class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:update, :destroy, :best]

  after_action :publish_answer, only: [:create]

  include Voted
  #include Commented
 
  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    
    if @answer.save
      redirect_to @answer.question
    end
  end

  def destroy
    if current_user.author?(@answer)
      @answer.destroy
      redirect_to @answer.question, notice: 'Ваш ответ удалён.'
    end
  end


  def update
    @answer.update(answer_params)
    @question = @answer.question
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
  end

  def publish_answer
     return if @answer.errors.any?
     ActionCable.server.broadcast "questions/#{@answer.question.id}/answers", answer: @answer.to_json
  end
end
