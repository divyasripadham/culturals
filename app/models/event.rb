class Event < ActiveRecord::Base
  belongs_to :college
  has_many :videos
  EVENT_TYPES = ["Cultural", "Tech", "Sports"]
  enum event_type: [:Cultural, :Tech, :Sports]

  def event_and_college
    "#{name}, #{college.name}, #{college.city}"
  end

end
