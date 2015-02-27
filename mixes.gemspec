# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mixes/version'

Gem::Specification.new do |spec|
  spec.name          = "mixes"
  spec.version       = Mixes::VERSION
  spec.authors       = ["Kuba Łopusiński"]
  spec.email         = ["siemakuba@gmail.com"]
  spec.summary       = %q{Load a Mixin with initial configuration.}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rspec", "~> 3.2"
end
