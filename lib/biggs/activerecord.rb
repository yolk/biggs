module Biggs
  module ActiveRecordAdapter
    
    def self.included(base)
      base.extend(InitialClassMethods)
    end
    
    module InitialClassMethods
      def biggs(method_name=nil, options={})
        self.extend(ClassMethods)
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
    
    module ClassMethods
      def biggs_value_methods
        read_inheritable_attribute(:biggs_value_methods) || write_inheritable_attribute(:biggs_value_methods, {})
      end
      
      def biggs_instance
        read_inheritable_attribute(:biggs_formatter) || write_inheritable_attribute(:biggs_formatter, Biggs::Formatter.new)
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
          self.send(key.to_sym)
        when Proc
          key.call(self).to_s
        when Array
          if key.all?{|it| it.is_a?(Symbol) }
            key.map{|method| self.send(method) }.reject(&:blank?).join("\n")
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