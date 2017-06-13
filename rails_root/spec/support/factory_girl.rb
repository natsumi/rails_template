require 'database_cleaner'

# Setup factory_girl for RSpec
RSpec.configure do |config|
  # So we don't have to preface factory_girl methods with FactoryGirl
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start

      # Enable linting
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
