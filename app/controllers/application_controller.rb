class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user!
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page"

      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: {}, status: 403 }
      end
    end
  end
end
