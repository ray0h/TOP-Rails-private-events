class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.all
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

  def update
    @user = User.find(current_user.id)
    @user.lists.find_by(event_id: params[:event_id]).update(rsvp: params[:rsvp])

    redirect_back(fallback_location: users_path)
  end

  private

  def users_params
    params.require(:user).permit(:name)
  end
end
