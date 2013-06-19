# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-pcc/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-pcc"
  spec.version       = VagrantPlugins::Pcc::VERSION
  spec.authors       = ["Derek Olsen"]
  spec.email         = ["derek.olsen@jivesoftware.com"]
  spec.description   = %q{Clean puppet cert}
  spec.summary       = %q{Clean puppet cert}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/) - %w(.vagrant puppet-cert-clean Vagrantfile)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
