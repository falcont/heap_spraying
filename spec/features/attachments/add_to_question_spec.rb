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

  scenario 'User adds file when asks question' do 
    fill_in 'Заголовок', with: 'Question title'
    fill_in 'Вопрос', with: 'Question body'
    attach_file 'Прикрепить файл', "#{Rails.root}/Gemfile"
    click_on 'Создать'

    expect(page).to have_link 'Gemfile', href: '/uploads/attachment/file/1/Gemfile'
  end

  scenario 'User adds several files when asks question', js: true do 
    fill_in 'Заголовок', with: 'Question title'
    fill_in 'Вопрос', with: 'Question body'
    attach_file 'Прикрепить файл', "#{Rails.root}/Gemfile"
    click_on 'Добавить файл'

    attach_file 'Прикрепить файл', "#{Rails.root}/Gemfile.lock"

    click_on 'Создать'

    #within '.attachments' do 
      page.has_link? 'Gemfile', href: '/uploads/attachments/file/1/Gemfile'
      page.has_link? 'Gemfile.lock', href: '/uploads/attachments/file/2/Gemfile.lock'
    #end
  end
end