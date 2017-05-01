# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "justify/version"

Gem::Specification.new do |spec|
  spec.name          = "justify"
  spec.version       = Justify::VERSION
  spec.authors       = ["TODO: Write your name"]
  spec.email         = ["code@getbraintree.com"]

  spec.summary       = "Justify monospace text"
  # spec.description   = "TODO"
  spec.homepage      = "https://github.com/mxhold/justify"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop", "~> 0.48.1"
  spec.add_development_dependency "pry"
end
