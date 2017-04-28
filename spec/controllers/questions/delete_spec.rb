require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do 

  before { @user = create(:user) }
  let(:question) { create(:question, user: @user) }

  describe 'DELETE #destroy' do 
    sign_in_user
    before { question }

    context 'Autenticated user delete own question' do 
      it 'delete question' do 
        expect { delete :destroy, params: {id: question} }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do 
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'Authenticated user delete not his own question' do 
      it 'delete question as not author' do 
        @user2 = create(:user)
        sign_in @user2

        expect { delete :destroy, params: { id: question} }.to_not change(Question, :count)
      end 

      it 'redirect to index view' do 
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end
  end

end