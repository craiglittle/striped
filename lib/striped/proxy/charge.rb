require 'striped/proxy/base'
require 'striped/api/operations'

module Striped
  module Proxy
    class Charge < Base
      include Striped::API::Operations :create, :fetch, :all

      def refund(arguments = nil)
        client.post("/#{resource}/#{resource_id}/refund", body: arguments)
      end

      def capture(arguments = nil)
        client.post("/#{resource}/#{resource_id}/capture", body: arguments)
      end

      def dispute(arguments = nil)
        client.post("/#{resource}/#{resource_id}/dispute", body: arguments)
      end

    end
  end
end
