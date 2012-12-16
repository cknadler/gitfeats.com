source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'pg'
gem 'thin'
gem 'haml'
gem 'haml-rails'
gem 'jquery-rails'
gem 'execjs'
gem 'omniauth'
gem 'omniauth-github'
gem 'gravtastic'
gem 'zurb-foundation', '~> 3.2.2'
gem 'simplecov'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'compass-rails' 
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

# Gems used in development
group :development do
  gem 'quiet_assets'
  gem 'debugger'
  gem 'annotate'

  # Better errors
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'rspec-rails', :group => [:test, :development]
# Gems used for testing
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rb-fsevent'
  gem 'faker'

  # Auto testing
  gem 'guard-rspec'
  gem 'guard-spork'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
end
