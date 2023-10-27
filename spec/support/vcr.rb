require "vcr"
require "webmock/rspec"

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = false

  config.filter_sensitive_data("<<<REDACTED_BEARER_TOKEN>>>") do |interaction|
    interaction.request.headers["Authorization"].first
  end
end
