source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

gem 'jbuilder'

gem 'jwt'

group :development do
  gem 'annotate'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0', require: false
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4', require: false
  gem 'ed25519', '>= 1.2', '< 2.0', require: false
  gem 'rubocop'
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails'
end

group :test do
  gem 'factory_bot_rails'
  gem 'test-prof'
end
