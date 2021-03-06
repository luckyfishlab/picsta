class User < ActiveRecord::Base
  include PublicActivity::Common
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :role_ids, :group_ids, :invited_by_group_id

  validates_with PostInviteValidator, :fields => [:name]

  after_create :create_subscriber_resource_chain
  after_invitation_accepted :add_to_role


  has_one :subscription
  has_one :plan, :through => :subscription

  has_many :albums

  has_many :memberships
  has_many :roles, :through => :memberships

  has_many :group_users
  has_many :groups, :through => :group_users


  def add_to_role
    r = Role.find_by_name(:viewer)
    r.create_membership! self unless r.nil?
  end

  def invited_by_name
    User.name_or_email(invited_by_id)
  end

  def self.name_or_email user_id
    user = User.find(user_id)
    if user.nil?
      'a user which is no longer active'
    else
      if user.name?
        user.name
      else
        user.email
      end
    end
  end

  def create_subscriber_resource_chain
    # awkward way to say we are a new customer
    if invitation_token.nil?
      # Add a subscriber role
      r = Role.find_by_name(:subscriber)
      r.create_membership! self unless r.nil?
      # Create subscriber resources
      g = Group.create!(:owner_id => id)
      g.create_group_user! self
    end
  end

end

