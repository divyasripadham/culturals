class VideosController < ApplicationController
  def index
    # puts "params value search1 string  #{params[:search1]}"
    # puts "params value search2 string  #{params[:search2]}"
    # if params[:searchbycollege]
    #   @videos_college = Video.joins(:event => :college).where("colleges.name = ?","Qeskymgr nqtru ovqamlz hoqfaw.")
    # elsif params[:searchbyevent]
    #   @videos_event = Video.joins(:event).where("events.name = ?","#{params[:search2]}")
    # end
    #
    # @videos_recent = Video.limit(12).order('created_at desc')

    @menu = params[:vfilter1]
    if(params[:vfilter1]=='recentvideos')
      @videos = Video.limit(12).order('created_at desc')
    elsif (params[:vfilter1]=='videosbytitle')
      @videos = Video.where("title = ?", "#{params[:search]}")
    elsif (params[:vfilter1]=='videosbycollege')
      @videos = Video.joins(:event => :college).where("colleges.name = ?","#{params[:search]}")
    elsif (params[:vfilter1]=='videosbyevent')
      @videos = Video.joins(:event).where("events.name = ?","#{params[:search]}")
    elsif (params[:vfilter1]=='videosbytype')

    end
    puts "params value search1 string:  #{params[:search]}"
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
