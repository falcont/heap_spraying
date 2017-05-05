class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :ordered, -> { order('best DESC') }

  def set_best
    question.answers.where(best: true).update_all(best: false)
    self.update!(best: true)
  end

end