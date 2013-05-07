require 'striped/proxy/base'
require 'striped/api/operations'

module Striped
  module Proxy
    class Event < Base
      include Striped::API::Operations :fetch, :all
    end
  end
end
