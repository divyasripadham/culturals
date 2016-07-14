class Event < ActiveRecord::Base
  belongs_to :college
  has_many :videos

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
    where("content LIKE ?", "%#{search}%")
  end
end
