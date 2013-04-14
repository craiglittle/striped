require 'helper'
require 'striped'
require 'webmock/rspec'
require 'json'

Striped.api_key     = 'api_key'
Striped.api_version = 'api_version'

def stub_get_with_auth(path)
  stub_request(:get, "https://#{Striped.api_key}:@api.stripe.com/v1#{path}")
end

def stub_post_with_auth(path)
  stub_request(:post, "https://#{Striped.api_key}:@api.stripe.com/v1#{path}")
end

def a_get_with_auth(path)
  a_request(:get, "https://#{Striped.api_key}:@api.stripe.com/v1#{path}")
end

def a_post_with_auth(path)
  a_request(:post, "https://#{Striped.api_key}:@api.stripe.com/v1#{path}")
end
