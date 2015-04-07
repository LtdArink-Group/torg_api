# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torg_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'torg_api'
  spec.version       = TorgApi::VERSION
  spec.authors       = ['Archakov Aleksandr']
  spec.email         = ['archakov@gmail.com']
  spec.description   = %q{API for Torg system}
  spec.summary       = %q{Torg API}
  spec.homepage      = 'https://github.com/kodram/torg_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
