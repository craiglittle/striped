require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class Invoice < Base
      include Striped::Proxy::Operations :create, :fetch, :update, :all

      def pay
        client.post("/invoices/#{resource_id}/pay")
      end

      def upcoming(arguments)
        client.get('/invoices/upcoming', body: arguments)
      end

    end
  end
end
