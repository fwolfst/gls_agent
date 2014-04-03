# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gls_agent/version'

Gem::Specification.new do |spec|
  spec.name          = 'gls_agent'
  spec.version       = GLSAgent::VERSION
  spec.authors       = ['Felix Wolfsteller']
  spec.email         = ['felix.wolfsteller@gmail.com']
  spec.summary       = %q{Fetches parcel labels from GLS webpage.}
  spec.description   = %q{Log into GLS site, create and save new parcel sticker.}
  spec.homepage      = 'https://github.com/fwolfst/gls_agent'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'mechanize'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
