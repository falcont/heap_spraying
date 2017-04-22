require 'rails_helper'

feature 'View question' do 


  given!(:question) { create(:question) }

  scenario 'Anyone can view question' do 
    visit questions_path
    save_and_open_page
    click_on 'Показать'

    expect(page).to have_content 'Текст вопроса'

  end

end