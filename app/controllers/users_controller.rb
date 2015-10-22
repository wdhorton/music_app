class UsersController < ApplicationController

  before_action :ensure_logged_in, except: [:new, :create, :activate]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      url = activate_users_url(activation_token: @user.activation_token)
      activation_msg = UserMailer.activation_email(@user, url)
      activation_msg.deliver
      flash[:errors] = ["You must activate your account before you log in."]
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    if @user
      render :show
    else
      redirect_to new_session_url
    end
  end

  def activate
    user = User.find_by_activation_token(params[:activation_token])

    if user && user.activated == false
      user.toggle! :activated
      login_user!(user)
      redirect_to user_url(user)
    else
      flash[:errors] = ["Activation failed, or you have already activated."]
      redirect_to new_session_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
