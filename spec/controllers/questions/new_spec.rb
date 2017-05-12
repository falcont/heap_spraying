require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do 
  describe 'GET #new' do
    sign_in_user
    
    before { get :new }
    
    it 'assigns a new question to @question' do 
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachment for question' do 
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end

  end
end