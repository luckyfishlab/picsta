source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.11'

gem 'rspec', :require => false

group :test, :development do
  gem 'sqlite3'
end
group :production do
  gem 'pg', :require => false
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem "thin", ">= 1.5.0"
gem "rspec-rails", ">= 2.12.2", :group => [:development, :test]
gem "database_cleaner", ">= 0.9.1", :group => :test
gem "email_spec", ">= 1.4.0", :group => :test
gem "cucumber", :require => false

gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false
gem "launchy", ">= 2.1.2", :group => :test
gem "capybara", ">= 2.0.2", :group => :test
gem "factory_girl_rails", ">= 4.2.0", :group => [:development, :test]
gem "bootstrap-sass", ">= 2.2.2.0"
gem "devise", ">= 2.2.3"
gem "devise_invitable"
gem "simple_form", ">= 2.0.4"
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "figaro", ">= 0.5.3"
gem "better_errors", ">= 0.3.2", :group => :development
gem "binding_of_caller", ">= 0.6.8", :group => :development
gem "libv8", ">= 3.11.8"
gem "therubyracer", ">= 0.11.3", :group => :assets, :platform => :ruby, :require => "v8"
gem "consul"# , :git => 'git://github.com/luckyfishlab/consul.git'
gem "assignable_values"

#gem 'masonry-rails', :git => 'git://github.com/kristianmandrup/masonry-rails.git'

# Support for images, s3
gem "carrierwave", '~> 0.8.0'
#gem "rmagick", '~> 2.13.2'
gem "mini_magick"
gem "fog", "~> 1.3.1"
gem 'rename'

gem 'newrelic_rpm'