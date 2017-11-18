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


  describe '.find_for_oauth' do 
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has authorization' do 
      it 'returns the user' do 
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end
    
  end
end