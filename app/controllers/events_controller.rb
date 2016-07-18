class EventsController < ApplicationController
  def index
    @events = Event.where("startdate >= ?",Date.today).order(startdate: :asc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end

  def edit
  end
end
