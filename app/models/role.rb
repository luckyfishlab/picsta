class Role < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => true

  has_many :memberships
  has_many :users, :through => :memberships

  def create_membership!(user)
    memberships.create!( user_id: user.id, role_id: id)
  end



  def destroy_membership!(user)
    memberships.find(user.id).destroy
  end
end
