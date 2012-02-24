lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'mobme/infrastructure/service/version'

Gem::Specification.new do |s|
  s.name        = "async_service"
  s.version     = AsyncService::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["MobME"]
  s.email       = ["engineering@mobme.in"]
  s.homepage    = "http://mobme.in/"
  s.summary     = %q{AsyncService is a library to create asynchronous SOA daemons}
  s.description = %q{The gem provides an abstraction for asynchronous workers that poll data from a queue and do work}
  
  s.required_rubygems_version = ">= 1.3.6"
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "flog"
  s.add_development_dependency "yard"
  s.add_development_dependency "ci_reporter"
  s.add_development_dependency "simplecov-rcov"
  
  s.add_dependency "hiredis", "~> 0.3.1"
  s.add_dependency "redis", "~> 2.2.0"
  s.add_dependency "true_queue", "~> 0.9"

  s.files              = `git ls-files`.split("\n") - ["Gemfile.lock", ".rvmrc"]
  s.test_files         = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths      = ["lib"]
end
