require_relative '../acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an author of answer
  I'd like to be able to attach files
} do 

  given(:user){ create(:user) }
  given(:question){ create(:question) }

  background do 
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when adds answer', js: true do 
    fill_in 'Новый ответ', with: 'Answer text'
    attach_file 'Прикрепить файл', "#{Rails.root}/Gemfile"
    click_on 'Ответить'

    within '.answers' do 
      expect(page).to have_link 'Gemfile', href: '/uploads/attachment/file/1/Gemfile'
    end
  end

  scenario 'User adds several files when create answer', js: true do
    fill_in 'Новый ответ', with: 'Answer text'
    attach_file 'Прикрепить файл', "#{Rails.root}/Gemfile"
    click_on 'Ответить'

    click_on 'Добавить файл'

    attach_file 'Прикрепить файл', "#{Rails.root}/Gemfile.lock"

    within '.answers' do 
      page.has_link? 'Gemfile', href: '/uploads/attachment/file/1/Gemfile'
      page.has_link? 'Gemfile', href: '/uploads/attachment/file/1/Gemfile.lock'
    end    

  end


end