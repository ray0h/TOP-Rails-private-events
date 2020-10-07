class EventsController < ApplicationController
  before_action :require_login

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

  private

  def events_params
    params.require(:event).permit(:name, :date, :location, invitee_list: [])
  end
end
