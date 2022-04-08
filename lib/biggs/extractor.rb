module Biggs
  class Extractor
    def initialize(options)
      @value_methods = {}
      Biggs::Formatter::FIELDS.each do |field|
        @value_methods[field] = options.delete(field) if options[field]
      end
    end

    def get_values(instance)
      values = {}
      Biggs::Formatter::FIELDS_WO_COUNTRY.each do |field|
        values[field] = get_value(instance, field)
      end
      values
    end

    def get_value(instance, field)
      key = @value_methods[field] || field

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
