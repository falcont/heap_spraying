class Question < ApplicationRecord
  has_many :answers
  validates :title, :body, presence: true

  belongs_to :user
end