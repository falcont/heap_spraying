require 'rails_helper'

feature 'View questions', %q{
  In order to view all questions
  As an user
  I want to be able to view list of questions
} do
  
  given!(:questions) { create_list(:question, 5) } 

  scenario 'Anyone can view list of questions' do
    visit questions_path
    save_and_open_page
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end

end