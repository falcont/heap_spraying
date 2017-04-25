require 'rails_helper'

feature 'View question' do 


  given!(:question) { create(:question) }
  given!(:answer) {create(:answer, question: question) }

  scenario 'Anyone can view question and it answers' do 
    visit questions_path
    click_on 'Показать'

    expect(page).to have_content question.body
    expect(page).to have_content answer.body
  end

end