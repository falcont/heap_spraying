class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(questions_params)
    @question.user = current_user

    if @question.save 
      redirect_to @question, notice: 'Вопрос создан!'
    else
      render :new
    end
  end

  private

  def questions_params
    params.require(:question).permit(:title, :body)
  end

end
