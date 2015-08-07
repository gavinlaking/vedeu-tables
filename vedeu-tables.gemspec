# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vedeu/tables/version'

Gem::Specification.new do |spec|
  spec.name          = "vedeu-tables"
  spec.version       = Vedeu::Tables::VERSION
  spec.authors       = ["Gavin Laking"]
  spec.email         = ["gavinlaking@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

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
end
