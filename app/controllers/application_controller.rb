class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exeption|
    #redirect_to root_url, alert: exeption.message
    respond_to do |format|
      format.json { head :forbidden }
      format.js { head :forbidden }

      format.html { redirect_to root_url, alert: exception.message }
    end
  end

  check_authorization unless: :devise_controller?
end


