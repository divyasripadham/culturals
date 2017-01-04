class SitemapsController < ApplicationController
  def index
    @events = Event.where("is_published = ?", true)

    respond_to do |format|
      format.xml
    end
  end
end
