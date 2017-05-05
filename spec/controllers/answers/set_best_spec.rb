require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  
before { @user = create(:user) }
let(:question) { create(:question, user: @user) }
let(:answer) { create(:answer, question: question, user: @user) }
sign_in_user

  describe 'PATCH #set_best' do 
    it 'set best answer' do 
      patch :set_best, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(answer.reload).to be_best
    end

    it 'render set_best template' do 
      patch :set_best, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(response).to render_template :set_best
    end
  end
end