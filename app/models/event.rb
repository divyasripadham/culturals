class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :college
  has_many :videos
  EVENT_TYPES = ["Cultural", "Tech", "Sports"]
  enum event_type: [:Cultural, :Tech, :Sports]

  # def event_and_college
  #   "#{name}, #{college.name}, #{college.city}"
  # end

  def should_generate_new_friendly_id?
    new_record? || slug.nil? || slug.blank? || name_changed?
  end

  def has_friendly_id_slug?
    slugs.where(slug: slug).exists?
  end

  def to_param
    slug
  end

end
