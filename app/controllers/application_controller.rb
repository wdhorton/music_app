class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :ensure_logged_in

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user.admin
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  private

  def ensure_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def check_if_admin
    unless admin?
      flash[:errors] = ["That page only accessible to admins."]
      redirect_to user_url(current_user)
    end
  end
end
