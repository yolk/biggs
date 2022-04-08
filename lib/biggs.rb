require 'biggs/format'
require 'biggs/formatter'
require 'yaml'

module Biggs
  FORMATS = (YAML.load_file(File.join(File.dirname(__FILE__), '..', 'formats.yml')) || {}).freeze
  COUNTRY_NAMES = (YAML.load_file(File.join(File.dirname(__FILE__), '..', 'country_names.yml')) || {}).freeze
end

if defined?(ActiveRecord) and defined?(ActiveRecord::Base) and !ActiveRecord::Base.respond_to?(:biggs_formatter)
  require 'biggs/activerecord'
end
