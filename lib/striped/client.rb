require 'striped/proxy'
require 'striped/object'

require 'faraday'
require 'faraday_middleware-multi_json'

module Striped
  class Client
    include Striped::Proxy

    attr_reader :api_key, :api_version

    API_ENDPOINT  = 'https://api.stripe.com'
    API_NAMESPACE = '/v1'
    NO_PASSWORD   = ''

    def initialize(api_key, api_version)
      @api_key     = api_key
      @api_version = api_version
    end

    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    def delete(path, options = {})
      request(:delete, path, options)
    end

    private

    def request(method, path, options)
      response = connection.send(method) do |request|
        request.url "#{API_NAMESPACE}#{path}", options[:params]
        request.headers[:stripe_version] = api_version if api_version_specified?
        request.body = options[:body]
      end.body

      Striped::Object.new(response)
    end

    def connection
      @connection ||= Faraday.new(url: API_ENDPOINT) do |connection|
        connection.request  :basic_auth, api_key, NO_PASSWORD
        connection.request  :url_encoded
        connection.response :multi_json, symbolize_keys: true
        connection.adapter  :net_http
      end
    end

    def api_version_specified?
      !!api_version
    end

  end
end
