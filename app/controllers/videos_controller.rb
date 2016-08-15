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
    puts "params value search1 string  #{params[:search]}"
    puts "params value params1  #{params[:vfilter1]}"

  end

  def show
  end

  def new
  end

  def edit
  end

  def search
    if params[:search].present?
      # search_string = params[:search]
      puts "params value search string 1 #{params[:search]}"
      @videos = Video.joins(:event).where("events.name = ?","#{params[:search]}")
    end
  end

end
