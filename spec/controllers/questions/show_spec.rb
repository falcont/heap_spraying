require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do 
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before { get :show, params: { id: question } }
  describe 'GET #show' do
    sign_in_user
    it 'assings the request question to @questions' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do 
      expect(response).to render_template :show
    end

    it 'builds new attachment for question answer' do 
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end
  end

  describe 'GET #show for unlogined user' do
    it 'assings the request question to @questions' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do 
      expect(response).to render_template :show
    end
  end

end