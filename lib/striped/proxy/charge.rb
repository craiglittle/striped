require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class Charge < Base
      include Striped::Proxy::Operations :create, :fetch, :all

      def refund(arguments = nil)
        client.post("/#{resource}/#{resource_id}/refund", body: arguments)
      end

      def capture(arguments = nil)
        client.post("/#{resource}/#{resource_id}/capture", body: arguments)
      end

    end
  end
end
