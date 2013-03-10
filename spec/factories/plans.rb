# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    name "myplan"
    price 500
    description "The silver plan includes 5GB of storage to store and share your memories."
  end
end
