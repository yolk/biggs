biggs is a small ruby gem/rails plugin for formatting postal addresses from over 60 countries.

### Install

As a ruby gem:

    gem install biggs

### Standalone usage

    f = Biggs::Formatter.new

    f.format("de", # <= ISO alpha 2 code
      :recipient  => "Yolk Sebastian Munz & Julia Soergel GbR",
      :street     => "Musterallee 12", # <= street + house number
      :city       => "Ausgedacht",
      :zip        => 12345,
      :state      => "Nowhere" # <= state/province/region
    )

returns

    "Yolk Sebastian Munz & Julia Soergel GbR
    Musterallee 12
    12345 Ausgedacht
    Germany"

At the moment Biggs::Formatter.new accepts only one option:

*blank_country_on* ISO alpha 2 code (single string or array) of countries the formatter should skip the line "country" (for national shipping).

    Biggs::Formatter.new(blank_country_on: "de")

With the data from the above example this would return:

    "Yolk Sebastian Munz & Julia Soergel GbR
    Musterallee 12
    12345 Ausgedacht"

### Usage with Class

    class Address
      include Biggs

      biggs :postal_address
    end

This adds the method postal_address to your Address-model, and assumes the presence of the methods/columns recipient, street, city, zip, state, and country to get the address data. Country should return the ISO-code (e.g. 'us', 'fr', 'de').

You can customize the method-names biggs will use by passing in a hash of options:

    class Address
      include Biggs

      biggs :postal_address,
            :zip => :postal_code,
            :country => :country_code,
            :street => Proc.new {|address| "#{address.street} #{address.house_number}" }
    end

You can pass in a symbol to let biggs call a different method on your Address-model, or a Proc-object to create your data on the fly.

You can even pass in a array of symbols:

    class Address
      include Biggs

      biggs :postal_address,
            :recipient => [:company_name, :person_name]
    end

This will call the methods company_name and person_name on your address-instance, remove any blank returned values and join the rest by a line break.

To access the formatted address string, simply call the provided method on an address instance:

    Address.new.postal_address

If you pass in a ISO alpha 2 code as :country that is not supported by biggs, it will choose the US-format for addresses with an state specified, and the french/german format for addresses without an state.

### Supported countries

biggs knows how to format addresses of over 60 different countries. If you are missing one or find an misstake, feel free to let us know, fork this repository and commit your additions.

* Argentina
* Australia
* Austria
* Bahrain
* Belgium
* Bosnia and Herzegovina
* Brazil
* Bulgaria
* Canada
* China
* Croatia
* Czech
* Denmark
* Egypt
* Finland
* France
* Germany
* Greece
* Greenland
* Hong Kong
* Hungary
* Iceland
* India
* Indonesia
* Ireland
* Israel
* Italy
* Japan
* Jordan
* Kuwait
* Lebanon
* Lichtenstein
* Luxembourg
* Macedonia
* Mexico
* Netherlands
* New Caledonia
* New Zealand
* Norway
* Oman
* Philippines
* Poland
* Portugal
* Qatar
* Romania
* Russian Federation
* Saudi Arabia
* Serbia and Montenegro
* Singapore
* Slovakia
* Slovenia
* South Africa
* South Korea
* Spain
* Sweden
* Switzerland
* Syrian Arab Republic
* Taiwan
* Thailand
* Turkey
* Ukraine
* United Arab Emirates
* United Kingdom
* United States of America
* Yemen

biggs is tested to behave well with ActiveSupport 3 to 7

Copyright (c) 2009-2023 Yolk Sebastian Munz & Julia Soergel GbR
