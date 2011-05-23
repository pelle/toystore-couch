# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "toy/couch/version"

Gem::Specification.new do |s|
  s.name        = "toystore-couch"
  s.version     = Toy::Couch::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Pelle Braendgaard']
  s.email       = ['pelle@stakeventures.com']
  s.homepage    = ''
  s.summary     = %q{CouchDB integration for Toystore}
  s.description = %q{CouchDB integration for Toystore}

  s.add_dependency('toystore', '~> 0.7.0')
  s.add_dependency('adapter-couch', '~> 0.1.2')

  s.files         = `git ls-files`.split("\n") - ['specs.watchr']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
