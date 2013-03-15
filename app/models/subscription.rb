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
  rescue Stripe::CardError => e
    # Since it's a decline, Stripe::CardError will be caught
    body = e.json_body
    err = body[:error]
    puts "Status is: #{e.http_status}"
    puts "Type is: #{err[:type]}"
    puts "Code is: #{err[:code]}"
    # param is '' in this case
    puts "Param is: #{err[:param]}"
    puts "Message is: #{err[:message]}"

    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card. #{err[:message]}"

    false

  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_plan(plan)
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      customer.update_subscription(:plan => plan.name.downcase)
      self.plan_id = plan.id
      save!
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

  def update_card(new_stripe_token)
    unless new_stripe_token.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      customer.card = new_stripe_token
      updated_customer = customer.save
      self.last_4_digits = updated_customer.active_card.last4
      save!
    end
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Sorry. we were unable to update your card, #{e.message}."
      false
  end

end
