class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
  before_action :authenticate_user!

  # I'm not clueful enough to exclude rails_admin as well as devise like so:
  #   check_authorization :unless => :devise_controller?
  # THerefore please subclass NonRailsAdminApplicationController instead of this one.
end
