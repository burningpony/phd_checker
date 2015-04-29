source 'http://rubygems.org'
ruby '2.2.2'
gem 'rails', '4.2.1'

gem 'pg'
gem 'heroku'

# Bundle gems needed for Haml
gem 'haml-rails'
gem 'newrelic_rpm'
gem 'jquery-rails'

gem 'font-awesome-rails'
gem 'airbrake'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'sass-rails', '>= 3.2'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'puma'
gem 'rails-assets-airbrake-js', source: 'https://rails-assets.org'
gem 'rails-assets-store.js', source: 'https://rails-assets.org'
gem 'coffee-rails'

group :development, :test do
  gem 'web-app-theme', '>= 0.6.2'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails', '>= 3.0'
  gem 'rspec-activemodel-mocks'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'simplecov', require: false
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'selenium-webdriver', '>= 2.35'
  gem 'poltergeist', github: 'teampoltergeist/poltergeist'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end
