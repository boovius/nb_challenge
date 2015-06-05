ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
Dir['spec/support/**/*.rb'].each do |file|
  require_relative File.join('..', file)
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.warnings = true

  config.order = :random

  Kernel.srand config.seed
  ActiveRecord::Base.logger.level = Logger::INFO
end
