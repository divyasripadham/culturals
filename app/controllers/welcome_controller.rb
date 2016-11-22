class WelcomeController < ApplicationController
  def index
    @videos = Video.limit(16).order('created_at desc')
  end

  def about
  end
end
