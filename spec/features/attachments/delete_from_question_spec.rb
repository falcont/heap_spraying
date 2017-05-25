require_relative '../acceptance_helper'

feature 'Delete attachments', %q{ 
  As an author of question
  I'd like be able to delete attachments
} do 

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:attachment) { create(:attachment, attachable: question) }


  scenario 'Author delete question attachment', js: true do 
    sign_in(user)
    visit question_path(question)

    click_on 'Удалить файл'

    expect(page).not_to have_link 'Gemfile'
  end

  scenario 'No author of question tries to delete attachment', js: true do 
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_link 'Удалить файл'
  end


  scenario 'Unauthenticated user tries to delete attachment', js: true do 
    visit question_path(question)

    expect(page).to_not have_link 'Удалить файл' 
  end
end