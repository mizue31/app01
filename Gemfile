source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '~> 4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# for deployment on HEROKU

gem "heroku"
group :development, :test do
  gem 'sqlite3'
  gem 'simplecov'
  gem 'ci_reporter'
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'poltergeist'
  gem 'turnip'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'protected_attributes'
end

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 5.0'
  gem 'coffee-rails', '~> 4.1.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

gem 'rack-contrib', :require => 'rack/contrib'
gem 'prototype-rails'
#gem 'i18n-js'

gem 'newrelic_rpm'
