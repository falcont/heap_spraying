class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  scope :ordered, -> { order('best DESC') }

  def set_best
    ActiveRecord::Base.transaction do 
      question.answers.where(best: true).update_all(best: false)
      self.update!(best: true)
    end
  end
end