class Comment < ApplicationRecord
  after_save :publish_comment, on: :create

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, :user_id, presence: true


  private

  def publish_comment
    ActionCable.server.broadcast(
      'comments',
      self.to_json
    )
  end


end