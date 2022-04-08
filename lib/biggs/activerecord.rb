require 'active_support/core_ext/class/attribute'

module Biggs
  module ActiveRecordAdapter
    extend ActiveSupport::Concern

    included do
      class_attribute :biggs_config, default: {}
    end

    class_methods do
      def biggs(method_name=:postal_address, options={})
        self.define_method(method_name) do
          value_methods = self.biggs_config[method_name][:value_methods]
          self.biggs_config[method_name][:instance].format(
            Helpers.biggs_get_value(self, :country, value_methods),
            Helpers.biggs_values(self, value_methods)
          )
        end

        value_methods = {}
        Biggs::Formatter::FIELDS.each do |field|
          value_methods[field] = options.delete(field) if options[field]
        end

        self.biggs_config = self.biggs_config.dup

        self.biggs_config[method_name] = {
          instance: Biggs::Formatter.new(options),
          value_methods: value_methods
        }
      end
    end

    module Helpers
      def self.biggs_values(instance, value_methods)
        values = {}
        Biggs::Formatter::FIELDS_WO_COUNTRY.each do |field|
          values[field] = self.biggs_get_value(instance, field, value_methods)
        end
        values
      end

      def self.biggs_get_value(instance, field, value_methods)
        key = value_methods[field] || field

        case key
        when Symbol
          instance.send(key.to_sym)
        when Proc
          key.call(instance).to_s
        when Array
          if key.all?{|it| it.is_a?(Symbol) }
            key.map{|method| instance.send(method) }.reject(&:blank?).join("\n")
          else
            raise "Biggs: Can't handle #{field} type Array with non-symbolic entries"
          end
        else
          raise "Biggs: Can't handle #{field} type #{key.class}"
        end
      end
    end
  end
end
