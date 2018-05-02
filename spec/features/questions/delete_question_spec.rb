require_relative '../acceptance_helper'

feature 'Delete question', %q{
  User removes the question
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }

  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user delete question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content 'Вопрос_1'

    click_on 'Удалить'

    expect(page).to have_content 'Question was successfully destroyed.'
    expect(page).to_not have_content 'Вопрос_1'
  end

  scenario 'Authenticated user tries to remove not his question' do
    sign_in(user2)
    visit question_path(question)
    expect(page).to_not have_content 'Удалить'
  end

  scenario 'Unauthenticated user tries to delete question' do
    visit question_path(question)
    expect(page).to_not have_content 'Удалить'
  end
end
