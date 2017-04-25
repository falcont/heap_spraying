require 'rails_helper'

feature 'User sing up', %q{
  In order to create account
  As a User
  I want to sign up in system
} do 

  scenario 'Unregistered user trying to sign up with valid attributes' do 
    visit new_user_registration_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'
  end


  scenario 'Unregistered user trying to sign up with invalid attributes' do 
    visit new_user_registration_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '12345'
    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end


  scenario 'Registered user trying to sign up' do
    user = User.create!(email: 'user@mail.com', password: '123456')
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

end