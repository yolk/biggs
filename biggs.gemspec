# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{biggs}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sebastian Munz"]
  s.date = %q{2009-05-21}
  s.description = %q{biggs is a small ruby gem/rails plugin for formatting postal addresses from over 60 countries.}
  s.email = %q{sebastian@yo.lk}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.textile"
  ]
  s.files = [
    "CHANGES.textile",
    "LICENSE",
    "README.textile",
    "Rakefile",
    "VERSION.yml",
    "lib/biggs.rb",
    "lib/biggs/activerecord.rb",
    "lib/biggs/formatter.rb",
    "spec/spec_helper.rb",
    "spec/unit/activerecord_spec.rb",
    "spec/unit/biggs_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/yolk/biggs}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{biggs is a small ruby gem/rails plugin for formatting postal addresses from over 60 countries.}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/unit/activerecord_spec.rb",
    "spec/unit/biggs_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
