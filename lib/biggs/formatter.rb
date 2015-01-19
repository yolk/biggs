module Biggs
  class Formatter

    FIELDS = [:recipient, :street, :city, :region, :postalcode, :country]

    def initialize(options={})
      @blank_country_on = [options[:blank_country_on]].compact.flatten.map{|s| s.to_s.downcase}
    end

    def format(iso_code, values={})
      values.symbolize_keys! if values.respond_to?(:symbolize_keys!)

      format = Biggs::Format.find(iso_code)
      format_string = (format.format_string || default_format_string(values[:region])).dup.to_s
      country_name = blank_country_on.include?(format.iso_code) ? "" : format.country_name || format.iso_code

      (FIELDS - [:country]).each do |key|
        format_string.gsub!(/\{\{#{key}\}\}/, (values[key] || "").to_s)
      end
      format_string.gsub!(/\{\{country\}\}/, country_name)
      format_string.gsub(/\n$/, "")
    end

    attr_accessor :blank_country_on, :default_country_without_region, :default_country_with_region

    private

    def default_format_string(region)
      region && region != "" ?
        Biggs.country[default_country_with_region || "us"].address_format :
        Biggs.country[default_country_without_region || "fr"].address_format
    end
  end

end
