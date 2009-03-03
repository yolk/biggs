# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{biggs}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sebastian Munz"]
  s.date = %q{2009-03-03}
  s.description = %q{biggs is a ruby tool to format postal addresses for over 60 countries. It is usable as a standalone ruby gem or it plug's itself into Rails/ActiveRecord.}
  s.email = %q{sebastian@yo.lk}
  s.files = ["README.textile", "VERSION.yml", "lib/biggs", "lib/biggs/activerecord.rb", "lib/biggs/formatter.rb", "lib/biggs.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/yolk/biggs}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{biggs is a ruby tool to format postal addresses for over 60 countries. It is usable as a standalone ruby gem or it plug's itself into Rails/ActiveRecord.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
