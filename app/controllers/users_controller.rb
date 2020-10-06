class UsersController < ApplicationController
  def index
    @users = User.all
    # if session[:user_id]
    #   @user = User.find_by(id: session[:user_id])
    # else
    #   @user = User.none
    # end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def users_params
    params.require(:user).permit(:name)
  end
end
