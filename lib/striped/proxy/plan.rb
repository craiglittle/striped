module Striped
  module Proxy
    class Plan
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(arguments)
        client.post('/plans', body: arguments)
      end

    end
  end
end
