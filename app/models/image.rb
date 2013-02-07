class Image < ActiveRecord::Base
  attr_accessible :album_id, :pic, :title
  belongs_to :album
  mount_uploader :pic, PicUploader

  validates_presence_of :pic


end