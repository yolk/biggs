require File.join(File.dirname(__FILE__), '..', 'spec_helper')

class BaseClass
  include Biggs

  Biggs::Formatter::FIELDS.each do |field|
    define_method(field) do
      field == :country ? "us" : field.to_s.upcase
    end
  end
end

class FooBarEmpty < BaseClass;end

class FooBar < BaseClass
  biggs :postal_address
end

class FooBarCustomFields < BaseClass
  biggs :postal_address, :country => :my_custom_country_method,
                  :city => :my_custom_city_method

  def my_custom_country_method
    "de"
  end

  def my_custom_city_method
    "Hamburg"
  end
end

class FooBarCustomBlankDECountry < BaseClass
  biggs :postal_address, :blank_country_on => "de"

  def country
    "DE"
  end
end

class FooBarCustomMethod < BaseClass
  biggs :my_postal_address_method
end

class FooBarCustomProc < BaseClass
  biggs :postal_address,
        :country => Proc.new {|it| it.method_accessed_from_proc + "XX"},
        :state => Proc.new {|it| it.state.downcase }

  def method_accessed_from_proc
    "DE"
  end
end

class FooBarCustomArray < BaseClass
  biggs :postal_address,
        :street => [:address_1, :address_empty, :address_nil, :address_2]

  def address_1
    "Address line 1"
  end

  def address_2
    "Address line 2"
  end

  def address_empty
    ""
  end

  def address_nil
    nil
  end
end

class FooBarMultiple < BaseClass
  biggs :postal_address_one
  biggs :postal_address_two,
        country: false,
        recipient: false
end

describe "Extended Class" do

  it "should include Biggs::Concern" do
    FooBar.included_modules.should be_include(Biggs::Concern)
  end

  it "should set class value biggs_config" do
    FooBar.class_eval("biggs_config").should be_is_a(Hash)
  end

  it "should respond to biggs" do
    FooBar.should be_respond_to(:biggs)
  end
end

describe "Extended Class Instance" do

  describe "Empty" do
    it "should not have postal_address method" do
      FooBarEmpty.new.should_not be_respond_to(:postal_address)
    end
  end

  describe "Standard" do
    it "should have postal_address method" do
      FooBar.new.should be_respond_to(:postal_address)
    end

    it "should return postal_address on postal_address" do
      FooBar.new.postal_address.should eql("RECIPIENT\nSTREET\nCITY STATE ZIP\nUnited States of America")
    end
  end

  describe "Customized Fields" do
    it "should return address from custom fields on postal_address" do
      FooBarCustomFields.new.postal_address.should eql("RECIPIENT\nSTREET\nZIP Hamburg\nGermany")
    end
  end

  describe "Customized Blank DE Country" do
    it "should return address wo country on postal_address" do
      FooBarCustomBlankDECountry.new.postal_address.should eql("RECIPIENT\nSTREET\nZIP CITY")
    end
  end

  describe "Customized Method name" do
    it "should have my_postal_address_method" do
      FooBarCustomMethod.new.should be_respond_to(:my_postal_address_method)
    end

    it "should return formatted address on my_postal_address_method" do
      FooBarCustomMethod.new.my_postal_address_method.should eql("RECIPIENT\nSTREET\nCITY STATE ZIP\nUnited States of America")
    end
  end

  describe "Customized Proc as Param" do
    it "should return formatted address for unknown-country DEXX" do
      FooBarCustomProc.new.postal_address.should eql("RECIPIENT\nSTREET\nCITY state ZIP\ndexx")
    end
  end

  describe "Customized array of symbols" do
    it "should return formatted address with two lines for street" do
      FooBarCustomArray.new.postal_address.should eql("RECIPIENT\nAddress line 1\nAddress line 2\nCITY STATE ZIP\nUnited States of America")
    end
  end

  describe "Multiple" do

    it "should return postal_address on postal_address_one" do
      FooBarMultiple.new.postal_address_one.should eql("RECIPIENT\nSTREET\nCITY STATE ZIP\nUnited States of America")
    end

    it "should return postal_address with alt country on postal_address_two" do
      FooBarMultiple.new.postal_address_two.should eql("STREET\nCITY STATE ZIP")
    end
  end

end
