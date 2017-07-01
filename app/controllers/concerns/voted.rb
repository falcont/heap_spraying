module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:vote_up, :vote_down, :cancel_vote]
  end

  def vote_up
    respond_to do |format|
      if !@votable.vote_author(current_user)
        if @votable.vote_up(current_user) && !current_user.author?(@votable)     
          format.json { render_json }
        end
      else
        format.json { render_errors }
      end
    end
  end

  def vote_down
    respond_to do |format|
      if !@votable.vote_author(current_user)
        if @votable.vote_down(current_user) && !current_user.author?(@votable)     
          format.json { render_json }
        end
      else
        format.json { render_errors }
      end
    end
  end


  def cancel_vote
    respond_to do |format| 
      if @votable.cancel_vote(current_user)
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
    render json: @votable.vote_rating
    #render json: @vote.as_json.merge(rating: @votable.vote_rating) - с этим что-то не получилось, видимо, не уловил.
  end

  def render_errors
    render json: @votable.errors.full_messages, status: :unprocessable_entity

  end


end
