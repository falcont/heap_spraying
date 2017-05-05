require_relative '../acceptance_helper'

feature 'Set the best answer', %q{
  In order to sort answers
  As author of question
  I want to set the best answer
} do 

  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:answer2) { create(:answer, question: question, user: user2) }


  scenario 'Author can set the best answer', js: true do 
    sign_in user
    visit question_path(question)

    within '.answer-1' do 
      click_on 'Лучший!'

      expect(page).to_not have_content 'Лучший!'
      expect(page).to have_content 'Помечен как лучший!'
    end
  end

  scenario 'Author of question can set other\'s answer as best', js: true do 
    sign_in user 
    visit question_path(question)

    within '.answer-1' do 
      click_on 'Лучший!'
      expect(page).to_not have_content 'Лучший!'
      expect(page).to have_content 'Помечен как лучший!'
    end

    within '.answer-2' do 
      click_on 'Лучший!'
      expect(page).to_not have_content 'Лучший!'
      expect(page).to have_content 'Помечен как лучший!'
    end

    within '.answer-1' do 
      expect(page).to_not have_content 'Помечен как лучший!'
    end
  end

  scenario 'Unauthenticated user can\'t set the best answer' do 
    visit question_path(question)
    expect(page).to_not have_content 'Лучший!'
  end

  scenario 'Only author of question can set the best answer' do 
    sign_in user2
    visit question_path(question)
    expect(page).to_not have_content 'Лучший!'
  end


end