class Subscription < ActiveRecord::Base
  attr_accessible :customer_id, :last_4_digits, :user_id
  attr_accessible :stripe_token, :coupon
  attr_accessor :stripe_token, :coupon

  belongs_to :user

  before_save :update_stripe
  ## TODO
    #cancel_subscription
    #expire
    #update_plan

    # update_stripe appears to be called every time a user logs in
    # this doesn't seem like a good idea
    def update_stripe
      return if user.email.include?(ENV['ADMIN_EMAIL'])
      return if user.email.include?('@example.com') and Rails.env.test?
      #return if Rails.env.production?
      return if !Rails.env.test? and !user.roles.where(:name => :silver).exists?

      if customer_id.nil?
        if !stripe_token.present?
          raise "Stripe token not present. Can't create account."
        end
        ## TODO look at :plan => memberships.first.role.name
        ## It was originally roles.first.name, but in this app
        ## the membership is what gets built,
        if coupon.blank?
          customer = Stripe::Customer.create(
            :email => user.email,
            :description => user.name,
            :card => stripe_token,
            :plan => 'silver'
          )
        else
          customer = Stripe::Customer.create(
            :email => user.email,
            :description => user.name,
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
        customer.email = user.email
        customer.description = user.name
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
