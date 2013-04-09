module Striped
  module Proxy
    class Charge
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(arguments)
        client.post('/charges', body: arguments)
      end

    end
  end
end
