module Biggs
  module ActiveRecordAdapter
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def biggs_value_methods
        read_inheritable_attribute(:biggs_value_methods) || write_inheritable_attribute(:biggs_value_methods, {})
      end
      
      def biggs_instance
        read_inheritable_attribute(:biggs_formatter) || write_inheritable_attribute(:biggs_formatter, Biggs::Formatter.new)
      end
      
      def biggs(method_name=nil, options={})
        self.send(:include, Biggs::ActiveRecordAdapter::InstanceMethods)
        alias_method(method_name || :postal_address, :biggs_postal_address)
        
        value_methods = {}
        Biggs::Formatter::FIELDS.each do |field|
          value_methods[field] = options.delete(field) if options[field]
        end
        write_inheritable_attribute(:biggs_value_methods, value_methods)
        write_inheritable_attribute(:biggs_formatter, Biggs::Formatter.new(options))
      end
    end
    
    module InstanceMethods
      
      def biggs_postal_address
        self.class.biggs_instance.format(biggs_country, biggs_values)
      end
    
      private
    
      def biggs_country
        self.send(self.class.biggs_value_methods[:country] || :country)
      end
    
      def biggs_values
        values = {}
        (Biggs::Formatter::FIELDS - [:country]).each do |field|
          values[field] = self.send(self.class.biggs_value_methods[field] || field)
        end
        values
      end
    end
  end
end