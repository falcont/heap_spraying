require_relative '../acceptance_helper'

feature 'Vote for the answer', %q{
  In to respect answer
  As an user 
  I want to be able to vote for the answer
} do 

  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }

  given!(:question) { create(:question, user: user) }

  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:answer2) { create(:answer, question: question, user: user2) }


  describe 'Authenticated user' do 
    before { sign_in(user) }

    context 'rate not own answer' do 
    before { visit question_path(question) }

      scenario 'positive voting', js: true do 
        within '.answers' do 
          expect(page).to have_content '0'
          find(:css, '.vote_up').click
          expect(page).to have_content '1'
        end
      end

      scenario 'negative voting', js: true do 
        within '.answers' do 
          expect(page).to have_content '0'
          find(:css, '.vote_down').click
          expect(page).to have_content '-1'
        end
      end

      scenario 'double voting', js: true do 
        within '.answers' do 
          find(:css, '.vote_up').click
          find(:css, '.vote_up').click
        end
        within '.vote_rating' do
          expect(page).to have_content '1'
        end
      end

      scenario 'see cancel link after voting', js: true do 
        within '.answers' do 
          find(:css, '.vote_up').click
          expect(page).to have_link 'cancel'
        end
      end

      scenario 'not to see cancel link before voting', js: true do 
        within '.answers' do 
          expect(page).not_to have_content 'cancel'
        end
      end

      scenario 'revoting', js: true do 
        within '.answers' do 
          find(:css, '.vote_up').click
          expect(page).to have_content '1'
          find(:css, '.cancel_vote').click
          expect(page).to have_content '0'
        end
      end
    end
  end

end