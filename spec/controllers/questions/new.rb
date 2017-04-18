require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do 
  describe 'GET #new' do
    before { get :new }
    
    it 'assigns a new Question to @Question' do 
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end

  end
end