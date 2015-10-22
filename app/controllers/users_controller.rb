class UsersController < ApplicationController

  before_action :ensure_logged_in, except: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
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

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
