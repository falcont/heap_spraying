require_relative '../acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  as an author of answer 
  I'm be able to edit my answer
} do 

  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }


  scenario 'Unauthenticated user trying to  edit answer' do 
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit' do 
      within '.answers' do 
        expect(page).to have_link 'Редактировать'
      end
    end

    scenario 'trying to edit his answer', js: true do 
      click_on 'Редактировать'
      within '.answers' do 
        fill_in 'Ответить', with: 'edited answer'
        click_on 'Соxранить'
        
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'trying to edit not his answer' do 
      sign_in user2
      visit question_path(question)

      expect(page).to_not have_link 'Редактировать'
    end
  end

end