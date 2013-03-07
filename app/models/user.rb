class User < ActiveRecord::Base
  include PublicActivity::Common
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :role_ids, :group_ids, :invited_by_group_id,:stripe_token, :coupon

  attr_accessor :stripe_token, :coupon

  validates_with PostInviteValidator, :fields => [:name]


  after_create :create_resource_chain
  before_save :update_stripe

  #before_destroy :cancel_subscription

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

  ## TODO
  #cancel_subscription
  #expire
  #update_plan
 ## TODO
  #cancel_subscription
  #expire
  #update_plan

  def update_stripe
    return if email.include?(ENV['ADMIN_EMAIL'])
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      ## TODO look at :plan => memberships.first.role.name
      ## It was originally roles.first.name, but in this app
      ## the membership is what gets built,
      if coupon.blank?
        customer = Stripe::Customer.create(
          :email => email,
          :description => name,
          :card => stripe_token,
          :plan => 'silver'
        )
      else
        customer = Stripe::Customer.create(
          :email => email,
          :description => name,
          :card => stripe_token,
          :plan => 'silver',
          :coupon => coupon
        )
      end
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    self.customer_id = customer.id
    self.stripe_token = nil
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end


  def expire
    puts "**************************************"
    puts "***********called expire event"
    #UserMailer.expire_email(self).deliver
    #destroy
  end

end

