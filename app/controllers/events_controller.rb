class EventsController < ApplicationController
  def index
    @menu = params[:efilter1]
    if(params[:efilter1]=='upcomingevents')
      @events = Event.where("startdate >= ?",Date.today).order(startdate: :asc)
    elsif (params[:efilter1]=='eventsbyname')
      @events = Event.where("name LIKE ?","#{params[:search]}")
    elsif (params[:efilter1]=='eventsbycollege')
      @events = Event.joins(:college).where("colleges.name LIKE ?","#{params[:search]}")
    elsif (params[:efilter1]=='eventsbycity')
      @events = Event.joins(:college).where("colleges.city LIKE ?","#{params[:search]}")
    elsif (params[:efilter1]=='eventsbytype')

    end
    puts "params value search1 string  #{params[:search]}"
    puts "params value params1  #{params[:efilter1]}"
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end

  def edit
  end
end
