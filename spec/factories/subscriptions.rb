# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    plan_id 1
    user_id 1
    customer_id "cus_1RGYAvwPgqDxvH"
    last_4_digits "4242"
  end
end

