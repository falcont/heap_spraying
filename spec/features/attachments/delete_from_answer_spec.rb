require_relative '../acceptance_helper'

feature 'Delete attachments', %q{ 
  As an author of question
  I'd like be able to delete attachments
} do 

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, user: user, question: question) }
  given!(:attachment) { create(:attachment, attachable: answer) }


  scenario 'Author deletes answer attachment', js: true do 
    sign_in(user)
    visit question_path(question)

    within '.answers' do 
      click_on 'Удалить файл'
      expect(page).not_to have_link 'Gemfile'
    end
  end

  scenario 'Not author tries to delete answer attachment', js: true do 
    sign_in(user2)
    visit question_path(question)

    within '.answers' do
      expect(page).not_to have_link 'Удалить файл'
    end
  end


  scenario 'Unathenticated user try to delete answer attachment', js: true do 
    visit question_path(question)

    within '.answers' do 
      expect(page).not_to have_link 'Удалить файл'
    end
  end
end