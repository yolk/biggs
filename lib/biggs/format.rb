module Biggs
  class Format
    attr_reader :country_name, :iso_code, :format_string, :country

    def initialize(iso_code)
      @iso_code      = iso_code.to_s.downcase
      @country       = Biggs.country[@iso_code]
      @country_name  = @country ? @country.name : nil
      @format_string = @country ? @country.address_format : nil
    end

    class << self
      def find(iso_code)
        entries_cache[iso_code] ||= new(iso_code)
      end

      private

      def entries_cache
        @entries_cache ||= {}
      end
    end
  end
end
