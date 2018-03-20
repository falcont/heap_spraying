require_relative '../acceptance_helper'


feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to sign in
} do

  given(:user) { create(:user) }

  scenario 'Registered user trying to sign in' do
    sign_in(user)
    
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end


  scenario 'Unregistered user trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'user2@mail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Sign in with Facebook' do
    visit new_user_session_path

    mock_auth_hash('facebook')

    click_on 'Sign in with Facebook'
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
    page.should have_content("mockuser")
    page.should have_content("Выйти")
  end

  scenario 'Sign in with Twitter' do
    visit new_user_session_path

    mock_auth_hash('twitter')

    click_on 'Sign in with Twitter'
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
    page.should have_content("mockuser")
    page.should have_content("Выйти")
  end
end