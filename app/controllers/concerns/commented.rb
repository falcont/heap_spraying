module Commented
  extend ActiveSupport::Concern

  included do 
    before_action :set_commentable, only: [:comment]
  end


  def comment
    respond_to do |format|
      @comment = @commentable.comment(params[:comment][:body], current_user)

      if @comment.valid?
        format.json { render_json }
      else
        format.json { render_error }
      end
    end
  end

  private

  def render_json
    render json: @comment
  end

  def render_error
    render json: @comment, status: :unprocessable_entity
  end

  def set_commentable
    model = controller_name.classify.constantize
    @commentable = model.find(params[:id])
  end
end