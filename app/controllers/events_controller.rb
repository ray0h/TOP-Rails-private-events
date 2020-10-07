class EventsController < ApplicationController
  before_action :require_login, :require_authorization, only: %i[edit update destroy]

  def index
    @past = Event.past
    @upcoming = Event.upcoming
  end

  def new
    @event = Event.new
    @users = User.all
  end

  def create
    @event = current_user.host_events.new(events_params)
    if @event.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
    @users = User.all
  end

  def update
    @event = current_user.host_events.find(params[:id])
    @event.update(events_params)

    redirect_to user_path(current_user.id)
  end

  def destroy
    @event = current_user.host_events.find(params[:id])
    @event.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def events_params
    params.require(:event).permit(:name, :date, :time, :location, invitee_list: [])
  end

  def require_authorization
    @event = Event.find(params[:id])
    redirect_to user_path(current_user.id) unless @event.creator.name == current_user.name
  end
end
