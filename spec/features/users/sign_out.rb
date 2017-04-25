require 'rails_helper'

feature 'User sign out', %q{
  In order to log out system
  As a user
  I want to sign out from system
} do 

  given(:user) { create(:user) }

  scenario 'Registered user try to sign out' do

    sign_in(user)
    save_and_open_page
    click_on 'Выйти'


    expect(page).to have_content 'Signed out successfully'
    expect(current_path).to eq root_path

  end
end