require File.expand_path("../../config/environment", __FILE__)

Dir['spec/support/**/*.rb'].each do |file|
  require_relative File.join('..', file)
end

# monkey patch to silence stupid warning can't get rid of
DatabaseCleaner.instance_variable_set :@cleaners, nil

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.backtrace_exclusion_patterns << /vendor\/bundle/
    config.backtrace_exclusion_patterns << /spec\/support\/database_cleaner/

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

  config.disable_monkey_patching!
  config.warnings = true

  config.order = :random

  Kernel.srand config.seed
  ActiveRecord::Base.logger.level = Logger::INFO
end
