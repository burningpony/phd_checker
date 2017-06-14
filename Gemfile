source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'
gem 'rails', '4.2.1'

gem 'pg'

# Bundle gems needed for Haml
gem 'haml-rails'
gem 'newrelic_rpm'
gem 'jquery-rails'

gem 'font-awesome-rails'
gem 'airbrake'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'puma'
gem 'rails-assets-airbrake-js', source: 'https://rails-assets.org'
gem 'rails-assets-store.js', source: 'https://rails-assets.org'
gem 'therubyracer'


group :development, :test do
  gem 'web-app-theme', '>= 0.6.2'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails', '>= 3.0'
  gem 'rspec-activemodel-mocks'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'pry'
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
