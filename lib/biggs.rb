require 'biggs/format'
require 'biggs/formatter'
require 'countries'

module Biggs
  class << self
    def country
      @@formats ||= Country
    end
  end
end

if defined?(ActiveRecord) and defined?(ActiveRecord::Base) and !ActiveRecord::Base.respond_to?(:biggs_formatter)
  require 'biggs/activerecord'
  ActiveRecord::Base.send :include, Biggs::ActiveRecordAdapter
end
