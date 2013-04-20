module Striped
  module Proxy
    class Base
      attr_reader :client, :resource, :resource_id

      def initialize(client, resource_id)
        @client      = client
        @resource    = "#{self.class.to_s.split('::').last.downcase}s"
        @resource_id = resource_id
      end

    end
  end
end
