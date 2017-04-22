require 'rails_helper'

feature 'View question' do 


  given!(:question) { create(:question) }

  scenario 'Anyone can view question' do 
    visit questions_path
    click_on 'Показать'

    expect(page).to have_content 'Тело вопроса'
  end

end