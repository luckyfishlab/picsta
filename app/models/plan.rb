class Plan < ActiveRecord::Base
  attr_accessible :description, :name, :price

  has_many :subscriptions

  def name_and_description
    "$#{price/100} #{name} #{description}".html_safe
  end
end
