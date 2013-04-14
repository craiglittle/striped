module Striped
  module Proxy
    class Customer
      attr_reader :client, :customer_id

      def initialize(client, customer_id)
        @client      = client
        @customer_id = customer_id
      end

      def create(arguments)
        client.post('/customers', body: arguments)
      end

    end
  end
end
