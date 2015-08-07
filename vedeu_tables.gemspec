# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vedeu/tables/version'

Gem::Specification.new do |spec|
  spec.name          = 'vedeu_tables'
  spec.version       = Vedeu::Tables::VERSION
  spec.authors       = ['Gavin Laking']
  spec.email         = ['gavinlaking@gmail.com']

  spec.summary       = 'A plugin for Vedeu.'
  spec.description   = 'Provides table rendering for Vedeu.'
  spec.homepage      = 'http://github.com/gavinlaking/vedeu-tables'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'guard',              '2.13.0'
  spec.add_development_dependency 'guard-minitest',     '2.4.4'
  spec.add_development_dependency 'minitest',           '5.7.0'
  spec.add_development_dependency 'minitest-reporters', '1.0.19'
  spec.add_development_dependency 'mocha',              '1.1.0'
  spec.add_development_dependency 'pry',                '0.10.1'
  spec.add_development_dependency 'rake',               '~> 10.0'
  spec.add_development_dependency 'rubocop',            '0.33.0'
  spec.add_development_dependency 'ruby-prof',          '0.15.8'
  spec.add_development_dependency 'simplecov',          '0.10.0'
  spec.add_development_dependency 'simplecov-console',  '0.2.0'
  spec.add_development_dependency 'yard',               '0.8.7.6'

  spec.add_dependency 'vedeu'
end
