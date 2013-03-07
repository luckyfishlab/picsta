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

  factory :paid_subscriber, class: 'User' do
    name 'Paid User'
    email 'paid.user@example.com'
    password 'changeme'
    password_confirmation 'changeme'
  end

  factory :controller_test_subscriber, class: 'User' do
    name 'Paid User'
    email 'paid.user@example.com'
    password 'changeme'
    password_confirmation 'changeme'

    after(:create) { |instance| instance.groups << create_list(:group,1)}


  end


end
