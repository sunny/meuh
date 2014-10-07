# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'meuh/version'

Gem::Specification.new do |spec|
  spec.name          = "meuh"
  spec.version       = Meuh::VERSION
  spec.authors       = ["Sunny Ripert"]
  spec.email         = ["sunny@sunfox.org"]
  spec.summary       = %q{IRC Bot AI}
  spec.description   = %q{Very low artificial intelligence for a very stupid IRC channel bot
companion.}
  spec.homepage      = "http://github.com/sunny/meuh"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
