$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'rspec'
require 'rspec/its'
require File.join(File.dirname(__FILE__), '..', 'lib', 'biggs')
require 'logger'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end
