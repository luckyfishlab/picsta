class AlbumStat < ActiveRecord::Base
  attr_accessible :album_id, :last_image_count

  belongs_to :album
end
