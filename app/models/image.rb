class Image < ActiveRecord::Base
  include PublicActivity::Model


  attr_accessible :album_id, :pic, :title
  belongs_to :album
  mount_uploader :pic, PicUploader

  validates_presence_of :pic
  before_save :save_updated_pic_attributes

  scope :next, lambda {|album_id, id| where("album_id = ?", album_id).where("id > ?", id).order("id ASC") }
  scope :previous, lambda {|album_id, id| where("album_id = ?", album_id).where("id < ?", id).order("id DESC") }

  def next
    Image.next(self.album_id, self.id).first
  end

  def previous
    Image.previous(self.album_id, self.id).first
  end

  def update_pic_attributes
    if pic.present?
      # add more attributes from carrierwave here if needed
      self.file_size = pic.file.size
    end
  end

  private

  def save_updated_pic_attributes
    if pic_changed?
      update_pic_attributes
    end
  end


end


