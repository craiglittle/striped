require 'striped/proxy/base'
require 'striped/api/operations'

module Striped
  module Proxy
    class Invoice < Base
      include Striped::API::Operations :create, :fetch, :update, :all

      def pay
        client.post("/invoices/#{resource_id}/pay")
      end

      def upcoming(arguments)
        client.get('/invoices/upcoming', body: arguments)
      end

      def lines(arguments = nil)
        client.get("/invoices/#{resource_id}/lines", body: arguments)
      end

    end
  end
end
