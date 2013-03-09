# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :viewer_role, :class => :role do
    name "viewer"
  end
  factory :admin_role, :class => :role do
    name "admin"
  end
  factory :subscriber_role, :class => :role do
    name "subscriber"
  end
end
