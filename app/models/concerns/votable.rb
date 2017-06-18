module Votable
  extend ActiveSupport::Concern

  included do 
    has_many :votes, as: :votable, dependent: :delete_all
  end

  def vote_up(user)
    self.votes.build(user: user).positive!
  end

  def vote_down(user)
    self.votes.build(user: user).negative!
  end


  def cancel_vote(user)
    self.votes.find_by(user: user)&.delete
  end

  def vote_author(user)
    self.votes.find_by(user: user).present?
  end

  def vote_rating
    self.votes.sum(:rating)
  end


  def have_voted(user)
    
  end


end