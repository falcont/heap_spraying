module Votable
  extend ActiveSupport::Concern

  included do 
    has_many :votes, as: :votable, dependent: :delete_all
  end

  def vote_up
    self.votes.build(user: user).positive
  end


  def vote_down
    self.votes.build(user: user).negative
  end

  def vote_rating
    self.votes.sum(:rating)
  end


end