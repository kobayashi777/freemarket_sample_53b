source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# 本番環境エラーのため追記
ENV['NOKOGIRI_USE_SYSTEM_LIBRARIES'] = 'YES'
gem 'nokogiri'

ruby '2.5.1'
gem 'rails', '~> 5.2.3'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'


gem 'coffee-rails', '~> 4.2'

gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'

gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'uniform_notifier', '~> 1.11'
  gem 'bullet'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'faker'
end

group :production do
  gem 'unicorn', '5.4.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'haml-rails'
gem 'erb2haml'
gem 'jquery-rails' 
gem 'jquery-ui-rails'
gem 'ancestry'
gem 'gretel'
gem 'devise'
gem 'payjp'
gem 'dotenv-rails'
gem "omniauth-rails_csrf_protection"
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

gem "aws-sdk-s3", require: false
gem 'mini_magick'
gem 'pry-byebug'
gem 'whenever', require: false
gem 'aws-sdk', '~> 3'
