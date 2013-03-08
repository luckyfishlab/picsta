class Album < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  attr_accessible :title, :user_id, :image_id, :folder_id

  belongs_to :user
  has_many :images
  has_one :album_stat, dependent: :destroy

  belongs_to :folder

  after_create :create_album_stat

  def get_album_cover
    if self.image_id.nil?
      image = self.images.first
    else
      image = Image.find(self.image_id)
      if image.nil?
        image = self.images.first
      end
    end
    image
  end


end
