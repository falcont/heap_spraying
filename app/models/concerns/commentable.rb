module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: commentable 
  end

  def comment(body, user)
    comments.create(body: body, user: user)
  end
end