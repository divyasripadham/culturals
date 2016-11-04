class Video < ActiveRecord::Base

  belongs_to :event
  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  validates :url, presence: true, format: YT_LINK_FORMAT
  before_create -> do
    uid = url.match(YT_LINK_FORMAT)
    self.uid = uid[2] if uid && uid[2]
  end
end
