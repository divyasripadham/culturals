class WelcomeController < ApplicationController
  def index
    @videos = Video.limit(16).order('created_at desc')
    set_meta_tags title: 'College Events and Videos',
              description: 'Visit Culturals.in to know about College cultural events and watch latest college dance and fashion show videos'
  end

  def about
  end
end
