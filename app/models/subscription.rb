class Subscription < ActiveRecord::Base
  attr_accessible :customer_id, :last_4_digits, :plan_id, :user_id, :plan
  #accepts_nested_attributes_for :plan_id

  belongs_to :plan
  belongs_to :user
end
