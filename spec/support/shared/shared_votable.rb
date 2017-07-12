RSpec.shared_examples 'votable' do |action, param|
  let!(:user) { create(:user) }
  let!(:own_test) { Test.create(user_id: user.id) }
  let!(:test) { Test.create(user_id: create(:user)) }

  before { routes.draw { post action.to_s => "tests##{action}" } }

  context 'as authorised user' do 
    sign_in_user

    context 'other votes' do 
      it 'assigns voted object' do 
        post action, params: { id: test.id }, format: :json
        expect(assigns(:votable)).to eq(test)
      end

      it 'save vote in db' do 
        expect { post action, params: { id: test.id}, format: :json }.to change( test.votes, :count).by(1)
      end


      context 'double voting' do 
        before { test.votes.create!(votable_id: test.id, user_id: user.id, rating: param) }
        it 'returns 403 code' do 
          post action, params: { id: test.id }, format: :json
          expect(response).to have_http_status(:forbidden)
        end
      end  
    end
    

    context 'own votes' do
      it 'returns 403 code' do 
        post action, params: { id: own_test.id }, format: :json
        expect(response).to have_http_status(:forbidden)
      end 
    end
  end

  context 'as unauthorised user' do
    it 'returns 401 code' do 
      post action, params: { id: test.id }, format: :json
      expect(response).to have_http_status(:forbidden)
    end 
  end
end