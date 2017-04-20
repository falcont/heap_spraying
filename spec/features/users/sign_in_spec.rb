require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to sign in
} do

  scenario 'Registered user trying to sign in' do
    User.create!(email: 'user@mail.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    expect(page).to have_content 'Signed in succesfully.'
    expect(current_path).to eq root_path
  end


  scenario 'Unregistered user trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'user2@mail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end


end