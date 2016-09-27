require 'rubygems'
# Need active support for to_json and symbolize_keys!
require 'active_support/all'

# Require webmock and VCR to test requests
require 'webmock/rspec'
require "fakeweb"

require 'vcr'
require 'rspec'

# Include our Gem
require 'kickfire'
require 'pry'


VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
end


RSpec.configure do |config|
  config.before(:suite) do
    FakeWeb.allow_net_connect = false
  end

  config.after(:suite) do
    FakeWeb.allow_net_connect = true
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = false
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end
