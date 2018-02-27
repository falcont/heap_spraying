class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to root_url, alert: exeption.message
  end
end
