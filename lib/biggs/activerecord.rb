require 'active_support/core_ext/class/attribute'

module Biggs
  module ActiveRecordAdapter
    def self.included(base)
      base.extend(InitialClassMethods)
    end

    module InitialClassMethods
      def biggs(method_name = nil, options = {})
        class_attribute :biggs_value_methods
        class_attribute :biggs_instance

        send(:include, Biggs::ActiveRecordAdapter::InstanceMethods)
        alias_method(method_name || :postal_address, :biggs_postal_address)

        value_methods = {}
        Biggs::Formatter::FIELDS.each do |field|
          value_methods[field] = options.delete(field) if options[field]
        end

        self.biggs_value_methods = value_methods
        self.biggs_instance = Biggs::Formatter.new(options)
      end
    end

    module InstanceMethods
      def biggs_postal_address
        self.class.biggs_instance.format(biggs_country, biggs_values)
      end

      private

      def biggs_country
        biggs_get_value(:country)
      end

      def biggs_values
        values = {}
        (Biggs::Formatter::FIELDS - [:country]).each do |field|
          values[field] = biggs_get_value(field)
        end
        values
      end

      def biggs_get_value(field)
        key = self.class.biggs_value_methods[field.to_sym] || field.to_sym

        case key
        when Symbol
          send(key.to_sym)
        when Proc
          key.call(self).to_s
        when Array
          if key.all? { |it| it.is_a?(Symbol) }
            key.map { |method| send(method) }.reject(&:blank?).join("\n")
          else
            fail "Biggs: Can't handle #{field} type Array with non-symbolic entries"
          end
        else
          fail "Biggs: Can't handle #{field} type #{key.class}"
        end
      end
    end
  end
end
