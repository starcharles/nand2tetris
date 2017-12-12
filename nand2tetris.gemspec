# coding: utf-8
# lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lb) unless $LOAD_PATH.include?(lib)
# require 'stree/version'

Gem::Specification.new do |spec|
  spec.name          = "nand"
  spec.authors       = [""]
  spec.email         = ["naotosatoh6@gmail.com"]
  spec.description   = %q{syntax tree}
  spec.summary       = %q{syntax tree}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  # spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry-byebug"
end
