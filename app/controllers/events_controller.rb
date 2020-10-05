class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.host_events.create(events_params)
    # @event.save
    redirect_to user_path(current_user.id)
    # else
      # render :new
    # end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def events_params
    params.require(:event).permit(:name, :date, :location)
  end
end
