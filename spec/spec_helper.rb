require 'simplecov'
SimpleCov.start

require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  
  require 'rails/application'
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!) # Rails 3.1

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'shoulda-matchers'
  require 'capybara/rspec'

  # Load data from seeds.rb (rake:db:seed equivalent)
  load "#{Rails.root}/db/seeds.rb" 

  OmniAuth.config.test_mode = true

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|

    # This is due to a possible bug with RSpec
    config.include Capybara::DSL

    config.treat_symbols_as_metadata_keys_with_true_values = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = true

    # Include factory girl syntax
    config.include FactoryGirl::Syntax::Methods
  end
end

Spork.each_run do
  FactoryGirl.reload
end
