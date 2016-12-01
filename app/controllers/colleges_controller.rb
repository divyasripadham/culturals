class CollegesController < ApplicationController
  # def add_college
  #   puts "hello"
  #   redirect_to :back
  # end

  def create
    puts "college name: #{params[:college][:name]}"
    redirect_to :back
  end

end
