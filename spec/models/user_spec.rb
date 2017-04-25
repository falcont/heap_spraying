require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :questions }


  context 'is an author?' do 
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:question) { create(:question, user: user) }


    it 'user is an author' do 
      expect(user).to eq question.user
    end

    it 'user is not author' do 
      expect(user2).to_not eq question.user
    end

  end
end