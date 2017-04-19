require 'rails_helper'

RSpec.describe AnswersController, type: :controller do 

  describe "GET #new" do

    let(:question) { create(:question) }
    before { get :new,  params: { question_id: question } }

    it "assigns an answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end

  end
end
