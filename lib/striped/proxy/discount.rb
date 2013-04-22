require 'striped/proxy/base'

module Striped
  module Proxy
    class Discount < Base

      def delete
        client.delete("/customers/#{resource_id}/discount")
      end

    end
  end
end
