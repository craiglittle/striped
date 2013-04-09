module Striped
  module Proxy
    class Charge
      attr_reader :client, :charge_id

      def initialize(client, charge_id)
        @client    = client
        @charge_id = charge_id
      end

      def create(arguments)
        client.post('/charges', body: arguments)
      end

      def fetch
        client.get("/charges/#{charge_id}")
      end

    end
  end
end
