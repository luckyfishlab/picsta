class Album < ActiveRecord::Base
  attr_accessible :title, :user_id

  belongs_to :user
  has_many :shares
  has_many :allowed_viewers, through: :shares, source: :user

  ### TODO : this model should have something about handling
  ### the share table when we destroy an album.

  def create_share!(user)
    shares.create!( user_id: user.id)
  end



  def destroy_share!(user)
    shares.find_by_user_id(user.id).destroy
  end

end
