require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class Invoice < Base
      include Striped::Proxy::Operations :create, :fetch, :update, :all

      def pay
        client.post("/invoices/#{resource_id}/pay")
      end

    end
  end
end
