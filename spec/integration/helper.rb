require 'helper'
require 'striped'
require 'webmock/rspec'
require 'vcr'
require 'json'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

Striped.api_key     = ENV['STRIPE_TEST_API_KEY']
Striped.api_version = ENV['STRIPE_TEST_VERSION']

def stub_get_with_auth(path)
  stub_request(:get, "https://#{ENV['STRIPE_TEST_API_KEY']}:@api.stripe.com/v1#{path}")
end

def stub_post_with_auth(path)
  stub_request(:post, "https://#{ENV['STRIPE_TEST_API_KEY']}:@api.stripe.com/v1#{path}")
end

def a_get_with_auth(path)
  a_request(:get, "https://#{ENV['STRIPE_TEST_API_KEY']}:@api.stripe.com/v1#{path}")
end

def a_post_with_auth(path)
  a_request(:post, "https://#{ENV['STRIPE_TEST_API_KEY']}:@api.stripe.com/v1#{path}")
end
