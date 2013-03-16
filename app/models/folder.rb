class Folder < ActiveRecord::Base
  attr_accessible :group_id

  has_many :albums

  def sum_group_storage_usage
    summation = 0
    albums.each do | album |
      album.images.each do | image |
        summation += image.file_size unless image.file_size.nil?
      end
    end
    summation
  end

end
