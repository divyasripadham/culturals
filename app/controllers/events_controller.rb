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
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new
    @event.name = params[:event][:name]
    @event.college_id = params[:event][:college_id].to_i
    @event.url = params[:event][:url]
    @event.description = params[:event][:description]
    event = params[:event]
    @event.startdate = Date.new event["startdate(1i)"].to_i, event["startdate(2i)"].to_i, event["startdate(3i)"].to_i
    @event.enddate = Date.new event["enddate(1i)"].to_i, event["enddate(2i)"].to_i, event["enddate(3i)"].to_i

    if @event.save
      flash[:notice] = "Event was saved successfully."
      redirect_to @event
    else
      flash.now[:alert] = "Error creating event. Please try again."
      render :new
    end

  end

end
