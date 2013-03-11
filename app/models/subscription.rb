class Subscription < ActiveRecord::Base
  attr_accessible :customer_id, :last_4_digits, :plan_id, :user_id, :plan, :stripe_token

  attr_accessor :stripe_token

  validates_presence_of :plan_id
  validates_presence_of :user_id

  belongs_to :plan
  belongs_to :user

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: user.name, email: user.email, plan: plan.name.downcase, card: stripe_token)
      self.customer_id = customer.id
      self.last_4_digits = customer.active_card.last4
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
