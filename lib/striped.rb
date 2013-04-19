require 'striped/client'
require 'striped/version'

require 'forwardable'

module Striped
  class << self
    extend Forwardable

    attr_accessor :api_key, :api_version

    delegate [:charge, :customer, :plan] => :client
  end

  def self.client
    Striped::Client.new(api_key, api_version)
  end

end
