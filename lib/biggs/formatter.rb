module Biggs
  class Formatter
    
    FIELDS = [:recipient, :street, :city, :state, :zip, :country]
    
    def initialize(options={})
      @blank_country_on = [options[:blank_country_on]].compact.flatten.map{|s| s.to_s.downcase}
    end
  
    def format(country_code, values={})
      values.symbolize_keys! if values.respond_to?(:symbolize_keys!)
      country_code = country_code.dup.to_s.downcase
    
      country_entry = (Biggs.formats[country_code] || default_country_entry(country_code, values))
      country_name = (country_entry["name"].dup || "").to_s
      country_format = (country_entry["format"].dup || "").to_s
    
      (FIELDS - [:country]).each do |key|
        country_format.gsub!(/\{\{#{key}\}\}/, (values[key] || "").to_s)
      end
    
      country_name = "" if blank_country_on.include?(country_code)
      country_format.gsub!(/\{\{country\}\}/, country_name)
    
      country_format.gsub(/\n$/,"")
    end
  
    attr_accessor :blank_country_on, :default_country_without_state, :default_country_with_state
  
    private
  
    def default_country_entry(country_code, values={})
      {
        "name" => country_code.to_s,
        "format" => (values[:state] && values[:state] != "" ?
                  Biggs.formats[default_country_with_state || "us"] :
                  Biggs.formats[default_country_without_state || "fr"])["format"]
      }
    end
  end
  
end