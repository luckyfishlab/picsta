class Plan < ActiveRecord::Base
  attr_accessible :description, :name, :price

  has_many :subscriptions
end
