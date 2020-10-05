class UsersController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      @user = User.none
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def users_params
    params.require(:user).permit(:name)
  end
end
