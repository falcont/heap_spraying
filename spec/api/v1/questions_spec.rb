require 'rails_helper'

describe 'Questions API' do 
  describe 'GET /index' do 
    context 'unathorized' do 
      it 'returns 401 status if there is no access_token' do 
        get '/api/v1/questions', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if there is invalid' do 
        get '/api/v1/questions', format: :json, access_token: '12345'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do 
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      before { get '/api/v1/questions', format: :json, access_token: access_token.token }


      it 'returns 200 status code' do 
        expect(response).to be_success
      end


      it 'returns list of questions' do 
        expect(response.body).to have_json_size(2)
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do 
          question = questions.first 
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end
  end
end