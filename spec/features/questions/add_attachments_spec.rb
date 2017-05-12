require_relative '../acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an author of question
  I'd like to be able to attach files
} do 

  given(:user){ create(:user) }

  background do 
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when  asks question' do 
    fill_in 'Заголовок', with: 'Question title'
    fill_in 'Вопрос', with: 'Question body'
    attach_file 'File', "#{Rails.root}/Gemfile"
    click_on 'Создать'

    expect(page).to have_content 'rails_helper.rb.rb'
  end


end