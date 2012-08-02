# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "biggs/version"

Gem::Specification.new do |s|
  s.name        = "biggs"
  s.version     = Biggs::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sebastian Munz"]
  s.email       = ["sebastian@yo.lk"]
  s.homepage    = "https://github.com/yolk/biggs"
  s.summary     = %q{biggs is a small ruby gem/rails plugin for formatting postal addresses from over 60 countries.}
  s.description = %q{biggs is a small ruby gem/rails plugin for formatting postal addresses from over 60 countries.}

  s.rubyforge_project = "biggs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord',            '~> 3.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec',       '>= 2.4.0'
  s.add_development_dependency 'sqlite3',     '>= 1.3.5'
end

