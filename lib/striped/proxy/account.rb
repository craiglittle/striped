require 'striped/proxy/base'

module Striped
  module Proxy
    class Account < Base

      def fetch
        client.get('/account')
      end

    end
  end
end
