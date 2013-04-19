module Striped
  module Proxy
    class Plan
      attr_reader :client, :plan_id

      def initialize(client, plan_id)
        @client  = client
        @plan_id = plan_id
      end

      def create(arguments)
        client.post('/plans', body: arguments)
      end

      def fetch
        client.get("/plans/#{plan_id}")
      end

    end
  end
end
