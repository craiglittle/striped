require 'striped/proxy/base'
require 'striped/api/operations'
require 'striped/proxy/subscription'
require 'striped/proxy/discount'

module Striped
  module Proxy
    class Customer < Base
      include Striped::API::Operations :create, :fetch, :update, :delete, :all

      def subscription
        Striped::Proxy::Subscription.new(client, resource_id)
      end

      def discount
        Striped::Proxy::Discount.new(client, resource_id)
      end

    end
  end
end
