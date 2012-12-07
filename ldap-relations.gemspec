# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ldap-relations/version'

Gem::Specification.new do |gem|
  gem.name          = "ldap-relations"
  gem.version       = Ldap::Relations::VERSION
  gem.authors       = ["Felix Clack"]
  gem.email         = ["felixclack@gmail.com"]
  gem.description   = %q{}
  gem.summary       = %q{Abstraction of filters to use with an LDAP library.}
  gem.homepage      = "http://felixclack.github.com/ldap-relations"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end