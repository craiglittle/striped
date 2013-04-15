module Striped
  module Proxy
    class Subscription
      attr_reader :client, :customer_id

      def initialize(client, customer_id)
        @client      = client
        @customer_id = customer_id
      end

      def update(arguments)
        client.post("/customers/#{customer_id}/subscription", body: arguments)
      end

    end
  end
end
