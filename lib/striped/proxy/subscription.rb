require 'striped/proxy/base'

module Striped
  module Proxy
    class Subscription < Base

      def update(arguments)
        client.post("/customers/#{resource_id}/subscription", body: arguments)
      end

      def cancel
        client.delete("/customers/#{resource_id}/subscription")
      end

    end
  end
end
