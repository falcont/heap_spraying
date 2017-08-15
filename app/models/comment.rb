class Comment < ApplicationRecord
  ater_create_commit: publish_comment

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, :user_id, presence: true


  private

  def publish_comment
    ActionCable.server.broadcast(
      'comments',
      comment: :body
    )
  end


end