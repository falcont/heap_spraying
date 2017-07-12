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




end