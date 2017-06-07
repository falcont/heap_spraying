module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:vote_up, :vote_down]
  end

  def vote_up
    respond_to do |format|
      if @votable.vote_up(current_user)
        format.json { render_json }
      end
    end
  end

  def vote_down
    respond_to do |format|
      if @votable.vote_down(current_user)
        format.json { render_json }
      end
    end
  end

  private

  def set_votable
    model = controller_name.classify.constantize
    @votable = model.find(params[:id])
  end

  def render_json
    render json: @votable
  end

  def render_errors

  end


end
