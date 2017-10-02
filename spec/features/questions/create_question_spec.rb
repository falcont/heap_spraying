require_relative '../acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to create questions
} do

  given(:user) { create(:user) }
  
  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Новый вопрос'
    fill_in 'Заголовок', with: 'Question title'
    fill_in 'Вопрос', with: 'Question body'
    click_on 'Создать'

    expect(page).to have_content 'Question was successfully created. !'
  end

  scenario 'Unauthenticated user tries to create question' do
    visit questions_path
    click_on 'Новый вопрос'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end