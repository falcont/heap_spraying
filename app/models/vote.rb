class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  enum rating: { positive: 1, negative: -1 }

  #validates :rating, :user_id, presence: true
end