class User < ActiveRecord::Base
  include PublicActivity::Common
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :role_ids

  has_many :albums


  has_many :memberships
  has_many :roles, :through => :memberships

  def invited_by_name
    u = User.find(invited_by_id)
    if u.nil?
      'a user which is no longer active'
    else
      if u.name.nil?
        u.email
      else
        u.name
      end
    end

  end
end
