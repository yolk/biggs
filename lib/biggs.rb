require 'active_support'
require 'active_support/core_ext'
require 'biggs/format'
require 'biggs/formatter'
require 'biggs/concern'
require 'yaml'

module Biggs
  FORMATS = (YAML.load_file(File.join(File.dirname(__FILE__), '..', 'formats.yml')) || {}).freeze
  COUNTRY_NAMES = (YAML.load_file(File.join(File.dirname(__FILE__), '..', 'country_names.yml')) || {}).freeze

  extend ActiveSupport::Concern

  included do
    include Biggs::Concern
  end
end
