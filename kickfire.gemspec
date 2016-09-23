# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kickfire/version'

Gem::Specification.new do |spec|
  spec.name          = "kickfire"
  spec.version       = Kickfire::VERSION
  spec.authors       = ["Stephen Reid"]
  spec.email         = ["stephen.reid@terminus.com"]
  spec.summary       = %q{Kickfire API Client}
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  #spec.files         = `git ls-files -z`.split("\x0")
  spec.files         = Dir["README.md","Gemfile","Rakefile", "lib/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "fakeweb"

end
