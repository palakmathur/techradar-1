ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "shoulda/matchers"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods

  include Warden::Test::Helpers
  Warden.test_mode!
  config.before(:example, admin: true) do
    User.create!(name: "Admin", email: "admin@example.com", username: "admin", admin: true, password: "abcd1234")
  end
end
