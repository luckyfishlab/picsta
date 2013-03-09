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
  attr_accessible :subscription_attributes


  validates_with PostInviteValidator, :fields => [:name]


  after_initialize { self.subscription ||= build_subscription }
  after_create :create_resource_chain


  #before_destroy :cancel_subscription


  has_one :subscription
  accepts_nested_attributes_for :subscription

  has_many :albums

  has_many :memberships
  has_many :roles, :through => :memberships

  has_many :group_users
  has_many :groups, :through => :group_users


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

  def create_resource_chain
    # awkward way to say we are a new customer
    if invitation_token.nil?
      g = Group.create(:owner_id => id)
      g.create_group_user! self
    end
  end



end

