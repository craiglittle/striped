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

      def fetch
        client.get("/customers/#{customer_id}")
      end

      def update(arguments)
        client.post("/customers/#{customer_id}", body: arguments)
      end

      def delete
        client.delete("/customers/#{customer_id}")
      end

    end
  end
end
