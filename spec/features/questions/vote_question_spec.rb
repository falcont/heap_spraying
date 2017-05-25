require_relative '../acceptance_helper'

feature 'Vote for the question', %q{
  In to respect question
  As an user 
  I want to be able to vote for the question
} do 

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question2) { create(:question, user: create(:user)) }

  describe 'Authenticated user' do 
    before { sign_in(user) }

    context 'rate not own questions' do 
      before { visit question_path(question2) }

      scenario 'positive voting', js: true do 
        within '.question' do 
          expect(page).to have_content '0'
          find(:css, '.vote_up').click
          expect(page).to have_content '1'
        end
      end

      scenario 'negative voting', js: true do 
        within '.question' do 
          expect(page).to have_content '0'
          find(:css, '.vote_down').click
          expect(page).to have_content '-1'
        end
      end

      scenario 'double voting', js: true do 
        within '.question' do 
          find(:css, 'vote_up').click
          find(:css, 'vote_up').click
        end
        expect(page).to have_content 'You can\'t vote twice'
      end

      scenario 'see cancel link after voting', js: true do 
        within '.question' do 
          find(:css, 'vote_up').click
          expect(page).to have_link 'cancel'
        end
      end

      scenario 'not to see cancel link before voting', js: true do 
        within '.question' do 
          expect(page).not_to have_content 'cancel'
        end
      end

      scenario 'revoting', js: true do 
        within '.question' do 
          find(:css, '.vote_up').click
          expect(page).to have_content '1'
          find(:css, '.vote_cancel').click
          expect(page).to have_content '0'
        end
      end
    end




  end

end