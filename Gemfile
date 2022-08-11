# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'bootsnap', require: false
gem 'grape', '~> 1.6', '>= 1.6.2'
gem 'grape-swagger', '~> 1.5'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'redis', '~> 4.0'
gem 'rswag-ui', '~> 2.4'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rspec-grape', github: 'datawowio/rspec-grape'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
