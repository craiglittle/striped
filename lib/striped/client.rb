require 'striped/proxy/charge'
require 'striped/proxy/customer'
require 'striped/proxy/plan'
require 'striped/proxy/coupon'
require 'striped/proxy/invoice'
require 'striped/proxy/invoice_item'
require 'striped/proxy/transfer'
require 'striped/proxy/account'
require 'striped/proxy/event'
require 'striped/object'

require 'faraday'
require 'faraday_middleware-multi_json'

module Striped
  class Client
    attr_reader :api_key, :api_version

    API_ENDPOINT  = 'https://api.stripe.com'
    API_NAMESPACE = '/v1'
    NO_PASSWORD   = ''

    def initialize(api_key, api_version)
      @api_key     = api_key
      @api_version = api_version
    end

    def charge(charge_id = nil)
      Striped::Proxy::Charge.new(self, charge_id)
    end

    def customer(customer_id = nil)
      Striped::Proxy::Customer.new(self, customer_id)
    end

    def plan(plan_id = nil)
      Striped::Proxy::Plan.new(self, plan_id)
    end

    def coupon(coupon_id = nil)
      Striped::Proxy::Coupon.new(self, coupon_id)
    end

    def invoice(invoice_id = nil)
      Striped::Proxy::Invoice.new(self, invoice_id)
    end

    def invoice_item(invoice_item_id = nil)
      Striped::Proxy::InvoiceItem.new(self, invoice_item_id)
    end

    def transfer(transfer_id = nil)
      Striped::Proxy::Transfer.new(self, transfer_id)
    end

    def account
      Striped::Proxy::Account.new(self)
    end

    def event(event_id = nil)
      Striped::Proxy::Event.new(self, event_id)
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
        request.url  "#{API_NAMESPACE}#{path}", options[:params]
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

  end
end
