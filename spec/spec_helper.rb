RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.backtrace_exclusion_patterns << /vendor\/bundle/i
  config.backtrace_exclusion_patterns << /spec\/support\/database_cleaner/

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
