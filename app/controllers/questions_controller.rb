class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy ]
  before_action :set_question, only: [ :show, :destroy, :update ]
  
  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(questions_params)

    if @question.save 
      redirect_to @question, notice: 'Вопрос создан!'
    else
      render :new
    end
  end

  def destroy
    if current_user.author?(@question)
      @question.destroy
      redirect_to questions_path, notice: 'Ваш вопрос удалён!'
    end
  end

  def update 
    @question.update(questions_params) if current_user.author?(@question)
  end

  private

  def questions_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end

end
