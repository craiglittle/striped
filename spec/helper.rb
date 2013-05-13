require 'rspec'
require 'rspec-spies'

require 'macros/proxy_operation_macros'
require 'macros/error_macros'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.color_enabled = true
  config.tty           = true

  config.include ProxyOperationMacros
  config.include ErrorMacros
end
