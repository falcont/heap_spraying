require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  
  let(:user) { create(:user) }
  let(:questions) { create_list(:question, 2, user: user) }
  before { get :index }

  describe 'GET #index' do
    sign_in_user

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #index for unlogine user' do
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end



end
