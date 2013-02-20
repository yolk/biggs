module Biggs
  class Format
    attr_reader :country_name, :iso_code, :format_string

    def initialize(iso_code)
      @iso_code = iso_code.to_s.downcase
      @country_name = Biggs.country_names[@iso_code]
      @format_string = Biggs.formats[@iso_code]
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