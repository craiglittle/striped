# coding: utf-8

require File.expand_path('../lib/striped/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'striped'
  gem.version       = Striped::VERSION
  gem.authors       = ['Craig Little']
  gem.email         = ['craiglttl@gmail.com']
  gem.description   = %q{A clean implementation of Stripe API Ruby bindings}
  gem.summary       = gem.description
  gem.homepage      = 'http://www.github.com/craiglittle/striped'
  gem.license       = 'MIT'

  gem.require_paths = ['lib']
  gem.files         += Dir.glob('lib/**/*.rb')
  gem.test_files    += Dir.glob('spec/**/*')

  gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'faraday_middleware-multi_json', '~> 0.0.5'

  gem.add_development_dependency 'rspec', '~> 2.12'
  gem.add_development_dependency 'webmock', '~> 1.9'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'coveralls', '~> 0.6'
end
