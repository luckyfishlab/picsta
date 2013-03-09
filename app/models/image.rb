class Image < ActiveRecord::Base
  include PublicActivity::Model

  tracked owner: Proc.new{ |controller, model| controller.current_user }

  attr_accessible :album_id, :pic, :title
  belongs_to :album
  mount_uploader :pic, PicUploader

  validates_presence_of :pic

  scope :next, lambda {|album_id, id| where("album_id = ?", album_id).where("id > ?", id).order("id ASC") }
  scope :previous, lambda {|album_id, id| where("album_id = ?", album_id).where("id < ?", id).order("id DESC") }

  def next
    Image.next(self.album_id, self.id).first
  end

  def previous
    Image.previous(self.album_id, self.id).first
  end
end