require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to create questions
} do
  
  scenario 'Authenticated user creates question' do
  User.create!(email: 'user@mail.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    visit questions_path
    click_on 'Новый вопрос'
    fill_in 'Заголовок', with: 'Question title'
    fill_in 'Вопрос', with: 'Question body'
    click_on 'Создать'

    page.should satisfy {|page| page.has_content?('Question title') or page.has_content?('Question bod')}
  end

  scenario 'Unauthenticated user tries to create question' do
    visit questions_path
    click_on 'Новый вопрос'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end