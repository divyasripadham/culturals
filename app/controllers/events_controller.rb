class EventsController < ApplicationController
  def index
    @menu = params[:efilter1]
    # To be used in JavaScript
    gon.menu = @menu
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
    puts "params value search  #{params[:search]}"
    puts "params value params  #{params[:efilter1]}"
    session[:search_results] = request.url
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.name = params[:event][:name]
    @event.college_id = params[:event][:college_id].to_i
    @event.url = params[:event][:url]
    @event.description = params[:event][:description]
    event = params[:event]
    @event.startdate = Date.new event["startdate(1i)"].to_i, event["startdate(2i)"].to_i, event["startdate(3i)"].to_i
    @event.enddate = Date.new event["enddate(1i)"].to_i, event["enddate(2i)"].to_i, event["enddate(3i)"].to_i

    if @event.save
      flash[:notice] = "Event was updated successfully."
      redirect_to @event
    else
      flash.now[:alert] = "Error saving event. Please try again."
      render :edit
    end
  end

  def destroy
     @event = Event.find(params[:id])
     if @event.destroy
       flash[:notice] = "\"#{@event.name}\" was deleted successfully."
      #  redirect_to action: :index
       redirect_to(session[:search_results] || default)
     else
       flash.now[:alert] = "There was an error deleting the event."
       render :show
     end
   end

end
