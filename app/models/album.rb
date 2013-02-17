class Album < ActiveRecord::Base
  attr_accessible :title, :user_id

  belongs_to :user
  has_many :shares, dependent: :destroy
  has_many :allowed_viewers, through: :shares, source: :user
  has_many :images
  has_one :album_stat, dependent: :destroy
  after_create :create_album_stat

  def create_share!(user)
    shares.create!( user_id: user.id)
  end

  def destroy_share!(user)
    shares.find_by_user_id(user.id).destroy
  end

end
