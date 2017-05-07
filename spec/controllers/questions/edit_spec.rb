require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do 
  
  let(:user){ create(:user) }
  let(:user2){ create(:user) }
  let(:question){ create(:question, user: @user) }

  describe 'PATCH #update' do
    sign_in_user
    
    context 'valid attributes' do 
      it 'assigns the requisted question to @question' do 
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do 
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }, format: :js
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'render update template' do 
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(response).to render_template :update
      end
    end
    
    context 'invalid attributes' do 
      before { patch :update, params: { id: question, question: { title: '', body: '' } }, format: :js }
      it 'does\'t change question attributes' do 
        question.reload
        expect(question.title).to eq question.title
        expect(question.body).to eq question.body
      end 
    end
  end
end
