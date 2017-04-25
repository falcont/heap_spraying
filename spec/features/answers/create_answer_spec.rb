require 'rails_helper'

feature 'Create answer', %q{
  In order to create an answer
  As an authenticate user
  I want to be able to give an answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) {create(:answer, question: question) }
  #given!(:invalid_answer) {create(:invalid_answer)}

  scenario 'Authenticated user creates answer' do
    sign_in(user)
    visit questions_path(question)
    
    click_on 'Показать'
    fill_in 'Новый ответ', with: answer.body
    click_on 'Ответить'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.body
  end

  scenario 'Authenticated user creates answer with invalid attributes' do
    sign_in(user)
    visit questions_path(question)
    
    click_on 'Показать'
    fill_in 'Новый ответ', with: answer.body = ''
    click_on 'Ответить'

    expect(answer).to be_invalid
  end

  scenario 'Unauthenticated user tries to create answer' do
    visit questions_path(question)
    click_on 'Показать'
    expect(page).to_not have_content 'Новый ответ'
  end
end