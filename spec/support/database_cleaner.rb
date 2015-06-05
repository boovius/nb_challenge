RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.clean_with :truncation, {:except => [
      'public.schema_migrations'
    ]}

    DatabaseCleaner.strategy = :transaction
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
