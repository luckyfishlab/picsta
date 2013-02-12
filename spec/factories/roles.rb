# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_role, :class => :role do
    name "user"
  end
  factory :admin_role, :class => :role do
    name "admin"
  end
end
