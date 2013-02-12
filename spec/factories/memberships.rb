# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory 'user3', class: 'User' do
    name 'Test User'
    email 'user@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now

    after(:create) { |instance| instance.roles << create_list(:user_role,1)}

  end
  factory 'user4', class: 'User' do
    name 'Test Admin'
    email 'admin@example.com'
    password 'changeme'
    password_confirmation 'changeme'

    after(:create) { |instance| instance.roles << create_list(:admin_role,1)}
  end
end




