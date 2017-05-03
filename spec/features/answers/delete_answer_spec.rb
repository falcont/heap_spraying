require_relative '../acceptance_helper'

feature 'Delete answer', %q{
  In order to delete an answer
  As an authenticated user
  I want to be able to delete own answer
} do

  given!(:user) { create(:user) }
  given!(:user2) { create(:user2) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) {create(:answer, question: question) }

  scenario 'Author delete answer' do
    sign_in(user)
    visit questions_path(question)
    click_on 'Показать'

    expect(page).to have_content answer.body

    click_on 'Удалить ответ'
    expect(page).to have_content 'Ваш ответ удалён.'
    expect(page).to_not have_content answer
    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user trying to delete not own answer' do
    sign_in(user2)
    visit questions_path(question)
    click_on 'Показать'
    expect(page).to_not have_content 'Удалить ответ.'
  end

  scenario 'Unauthenticated user trying to delete answer' do
    visit questions_path(question)
    click_on 'Показать'
    expect(page).to_not have_content 'Удалить ответ.'
  end

end
