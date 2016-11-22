class VideosController < ApplicationController
  def index
    
    @menu = params[:vfilter1]
    # To be used in JavaScript
    gon.menu = @menu
    if(params[:vfilter1]=='recentvideos')
      @videos = Video.limit(16).order('created_at desc')
    elsif (params[:vfilter1]=='videosbytitle')
      @videos = Video.where("title LIKE ?", "%#{params[:search]}%")
    elsif (params[:vfilter1]=='videosbycollege')
      @videos = Video.joins(:event => :college).where("colleges.id = ?", params[:college_id])
    elsif (params[:vfilter1]=='videosbyevent')
      @videos = Video.joins(:event).where("events.name LIKE ?","%#{params[:search]}%")
    elsif (params[:vfilter1]=='videosbytype')
      # @videos = Video.joins(:event).where( event_type: Event.event_types["#{params[:event_type]}"])
      # @videos = Video.joins(:event).where(events: {event_type: '#{params[:event_type]}'})
    end
    puts "params value search1 event_type:  #{params[:event_type]}"
    puts "params value params1:  #{params[:vfilter1]}"
    session[:search_results] = request.url
  end

  def show
    @uid = params[:uid]
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to(session[:search_results] || default)
    else
      render 'new'
    end
  end

  def edit
  end

  # def search
  #   if params[:search].present?
  #     # search_string = params[:search]
  #     puts "params value search string 1 #{params[:search]}"
  #     @videos = Video.joins(:event).where("events.name = ?","#{params[:search]}")
  #   end
  # end

  private

  def video_params
    params.require(:video).permit(:event_id, :title, :url)
  end

end
