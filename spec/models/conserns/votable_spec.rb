require 'rails_helper'

describe 'Votable'  do
  with_model :WithVotable do 
    table do |t|
      t.integer :user_id
    end
    model do 
      include Votable
    end
  end

  let(:user) { create(:user) }
  let(:votable) { WithVotable.create(user_id: user.id) }

  it '#vote_up' do 
    expect(votable.vote_up(user)).to be_truthy
  end

  it '#vote_down' do 
    expect(votable.vote_down(user)).to be_truthy
  end


  it '#cancel_vote' do 
    votable.vote_up(user)
    expect { votable.cancel_vote(user).to change(votable.votes, :count).from(1).to(0) }
  end


  it '#vote_rating' do 
    votable.vote_up(user)
    expect(votable.vote_rating).to eq(1)
    votable.vote_down(create(:user))
    expect(votable.vote_rating).to eq(0)
  end


  context '#voted?' do 
    it 'voted' do 
      votable.vote_up(user)
      expect(votable).to be_voted(user)
    end

    it 'not voted' do 
      expect(votable).not_to be_voted(user)
    end
  end

end