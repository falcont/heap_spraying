require_relative '../acceptance_helper'

feature 'Edit question', %q{
  As an author of question
  I want to edit my question
} do 

  given!(:user){ create(:user) }
  given!(:question){ create(:question, user: user) }

  
  describe 'Authenticated user' do 
    before do 
      sign_in user
      visit question_path(question)
    end

    scenario 'sees editing link' do 
      within '.question' do 
        expect(page).to have_content 'Редактировать'
      end
    end

    scenario 'tries to edit own question', js: true do 
      click_on 'Редактировать'
      
      within ".question" do
        fill_in 'Заголовок', with: 'edited question title'
        fill_in 'Вопрос', with: 'edited question body'
        click_on 'Сохранить'

        expect(page).to have_content 'edited question title'
        expect(page).to have_content 'edited question body'
        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
      end
    end

    scenario 'tries to edit own question with blank title', js: true do 
      click_on 'Редактировать'
      within '.question' do 
        fill_in 'Заголовок', with: ''
        click_on 'Сохранить'

        expect(page).to have_content 'Title can\'t be blank'
      end
    end

    scenario 'tries to edit own question with blank body', js: true do 
      click_on 'Редактировать'
      within '.question' do 
        fill_in 'Вопрос', with: ''
        click_on 'Сохранить'

        expect(page).to have_content 'Body can\'t be blank'
      end
    end


  end

  scenario 'Authenticated user tries to edit not his own question' do 
    user2 = create(:user)
    sign_in user2
    visit question_path(question)
    
    within '.question' do 
      expect(page).to_not have_link 'Редактировать'
    end
  end

  scenario 'Unauthenticated user tries to edit question' do 
    visit question_path(question)
    within '.question' do 
      expect(page).to_not have_link 'Редактировать'
    end
  end
end
