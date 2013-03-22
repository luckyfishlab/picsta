# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.create({ :name => role })
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name

puts 'DEFAULT ADMIN'
user = User.find_by_name ENV['ADMIN_NAME']
role = Role.find_by_name :admin
role.create_membership!(user)
puts "#{role.name}: " << user.name

puts 'DEFAULT PLAN'
plan = Plan.find_or_create_by_name :name => 'Standard', :price => 1000, :description => "5GB of storage with 10 invitations"
puts 'plan: ' << plan.name