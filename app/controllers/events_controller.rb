class EventsController < ApplicationController
  def index
    @events = Event.where("startdate >= ?",Date.today).order(startdate: :asc)
  end

  def show
  end

  def new
  end

  def edit
  end
end
