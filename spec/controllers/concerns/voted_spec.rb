require 'rails_helper'

class TestsController < ApplicationController; end

describe ApplicationController, type: :controller do 

  with_model :Test do 
    table do |t| 
      t.integer :user_id
    end

    model do 
      include Votable
    end
  end

  controller TestsController do 
    include Voted
  end


  describe 'POST #vote_up' do 
    it_behaves_like 'votable', :vote_up, 1
  end

  describe 'POST #vote_down' do 
    it_behaves_like 'votable', :vote_down, -1
  end

  describe 'DELETE #cancel_vote' do
    let!(:user) { create(:user) }
    let!(:test) { Test.create(user_id: create(:user)) }
    let!(:own_test) { Test.create!(user_id: user.id) }

    before { routes.draw { post 'cancel_vote' => 'tests#cancel_vote' } }

    
    context 'as authorized user' do 
      sign_in_user

      context "own votable" do 
        before { own_test.votes.create!(votable_id: own_test.id, user_id: user.id, rating: 1) }

        it 'delete vote' do 
          expect { delete :cancel_vote, params: { id: own_test.id }, format: :json }.to change(own_test.votes, :count).by(-1)
        end
      end

      context "other's votable" do 
        it 'do not delete vote' do 
          expect { delete :cancel_vote, params: { id: test.id }, format: :json }.not_to change(test.votes, :count)
        end
      end
    end

    context 'as unathorized user' do 
      it 'can not delete vote' do
        expect {delete :cancel_vote, params: { id: own_test.id }, format: :json}.to raise_error(ActiveRecord::RecordInvalid,"Validation failed: User must exist, User can't be blank")
      end  
    end
  end
end