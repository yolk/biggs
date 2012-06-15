require 'biggs/formatter'
require 'yaml'

module Biggs
  class << self
    def formats
      @@formats ||= YAML.load_file(File.join(File.dirname(__FILE__), '..', 'formats.yml')) || {}
    end
  end
end

if defined?(ActiveRecord) and defined?(ActiveRecord::Base) and !ActiveRecord::Base.respond_to?(:biggs_formatter)
  require 'biggs/activerecord'
  ActiveRecord::Base.send :include, Biggs::ActiveRecordAdapter
end