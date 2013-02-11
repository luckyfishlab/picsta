# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
  factory :user2, class: 'User' do
    name 'Another Tester'
    email 'another.tester@example.com'
    password 'changeme'
    password_confirmation 'changeme'
  end
end
