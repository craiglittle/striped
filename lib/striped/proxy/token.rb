require 'striped/proxy/base'
require 'striped/api/operations'

module Striped
  module Proxy
    class Token < Base
      include Striped::API::Operations :create, :fetch
    end
  end
end
