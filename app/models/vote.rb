class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  enum rating: { positive: 1, negative: -1 }

  validates :rating, :user_id, presence: true
  #validates :user_id, uniqueness: { scope: [:votable_id, :votable_type], message: :double_vote }
end