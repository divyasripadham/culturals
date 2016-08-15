class Event < ActiveRecord::Base
  belongs_to :college
  has_many :videos

end
