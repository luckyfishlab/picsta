class Group < ActiveRecord::Base
  attr_accessible :owner_id

  has_many :group_users
  has_many :users, :through => :group_users

  has_one :folder, dependent: :destroy

  after_create :create_folder



  def create_group_user!(user)
    group_users.create!( user_id: user.id, group_id: id)
  end



  def destroy_group_user!(user)
    group_users.find(user.id).destroy
  end
end
