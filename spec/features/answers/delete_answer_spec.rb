require_relative '../acceptance_helper'

feature 'Delete answer', %q{
  In order to delete an answer
  As an authenticated user
  I want to be able to delete own answer
} do

  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) {create(:answer, question: question, user: user) }

  scenario 'Author delete answer', js: true do
    sign_in user
    visit question_path(question)
    expect(page).to have_content answer.body

    click_on 'Удалить ответ'
    expect(page).to have_content 'Answer was successfully destroyed.'
    expect(page).to_not have_content answer
    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user trying to delete not own answer' do
    sign_in(user2)
    visit question_path(question)
    
    expect(page).to_not have_content 'Удалить ответ.'
  end

  scenario 'Unauthenticated user trying to delete answer' do
    visit question_path(question)
    
    expect(page).to_not have_content 'Удалить ответ.'
  end

end
