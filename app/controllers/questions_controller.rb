class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy ]
  before_action :set_question, only: [ :show, :destroy, :update ]
  before_action :build_answer, only: :show

  after_action :publish_question, only: [:create]

  respond_to :html

  include Voted
  
  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def create
    respond_with @question = current_user.questions.create(questions_params)
  end

  def destroy
    respond_with @question.destroy if current_user.author?(@question)
  end

  def update 
    @question.update(questions_params) if current_user.author?(@question)
    respond_with @question
  end


  private

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def build_answer
    @answer = @question.answers.build
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end
end
