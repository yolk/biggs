$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'rspec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'biggs')
require 'logger'

ActiveRecord::Base.logger = Logger.new('/tmp/biggs.log')
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => '/tmp/biggs.sqlite')
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :base_tables, :force => true do |table|
    table.string :name
  end
end