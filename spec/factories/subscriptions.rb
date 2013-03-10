# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    plan_id 1
    user_id 1
    customer_id "MyString"
    last_4_digits "MyString"
  end
end
