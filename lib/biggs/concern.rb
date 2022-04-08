require 'active_support'
require 'active_support/core_ext/class/attribute'
require 'biggs/extractor'
require 'biggs/formatter'

module Biggs
  module Concern
    extend ActiveSupport::Concern

    included do
      class_attribute :biggs_config, default: {}
    end

    class_methods do
      def biggs(method_name=:postal_address, options={})
        self.define_method(method_name) do
          formatter = self.biggs_config[method_name][:formatter]
          extractor = self.biggs_config[method_name][:extractor]
          formatter.format(
            extractor.get_value(self, :country),
            extractor.get_values(self)
          )
        end

        self.biggs_config = self.biggs_config.dup

        self.biggs_config[method_name] = {
          formatter: Biggs::Formatter.new(options),
          extractor: Biggs::Extractor.new(options)
        }
      end
    end
  end
end
