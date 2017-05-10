require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should belong_to :user }
  it { have_db_index :question_id }
  it { have_db_index :user_id }

  describe 'set best' do 
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'answer is true' do 
      answer = create(:answer, question: question, user: user)
      answer.set_best
      expect(answer.reload).to be_best
    end

    it 'only one answer' do 
      answer = create(:answer, question: question, user: user)
      answer.set_best
      answer2 = create(:answer, question: question, user: user)
      answer2.set_best
      expect(answer.reload).to_not be_best
      expect(answer2.reload).to be_best
    end
  end
end

