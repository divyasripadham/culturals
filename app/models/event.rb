class Event < ActiveRecord::Base
  belongs_to :college
  has_many :videos

  enum event_type: [ :Cultural, :Tech, :Sports ]
end
