require 'biggs/formatter'

module Biggs
  class << self
    def formats
      @@formats ||= YAML.load_file(File.join(File.dirname(__FILE__), '..', 'formats.yml')) || {}
    end
    
    def enable_activerecord
      return if ActiveRecord::Base.respond_to? :biggs_formatter
      require 'biggs/activerecord'
      ActiveRecord::Base.send :include, Biggs::ActiveRecordAdapter
    end
  end
end

if defined?(ActiveRecord) and defined?(ActiveRecord::Base)
  Biggs.enable_activerecord
end

