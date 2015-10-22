class SessionsController < ApplicationController

  before_action :ensure_logged_in, only: [:destroy]
  before_action :redirect_logged_in_users, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user && user.activated
      login_user!(user)
      redirect_to user_url(user)
    else
      if user && !user.activated
        flash.now[:errors] = ["You must first activate your account."]
      else
        flash.now[:errors] = ["Incorrect username and/or password."]
      end
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  private

  def redirect_logged_in_users
    if logged_in?
      redirect_to user_url(current_user)
    end
  end

end
