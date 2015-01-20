require 'rubygems'
require 'active_record'
require File.join(File.dirname(__FILE__), '..', 'spec_helper')

class BaseTable < ActiveRecord::Base
  Biggs::Formatter::FIELDS.each do |field|
    define_method(field) do
      field == :country ? 'us' : field.to_s.upcase
    end
  end
end

class FooBarEmpty < BaseTable; end

class FooBar < BaseTable
  biggs :postal_address
end

class FooBarCustomFields < BaseTable
  biggs :postal_address, country: :my_custom_country_method,
                         city: :my_custom_city_method

  def my_custom_country_method
    'de'
  end

  def my_custom_city_method
    'Hamburg'
  end
end

class FooBarCustomBlankDECountry < BaseTable
  biggs :postal_address, blank_country_on: 'de'

  def country
    'DE'
  end
end

class FooBarCustomMethod < BaseTable
  biggs :my_postal_address_method
end

class FooBarCustomProc < BaseTable
  biggs :postal_address,
        country: proc { |it| it.method_accessed_from_proc + 'XX' },
        region: proc { |it| it.region.downcase }

  def method_accessed_from_proc
    'DE'
  end
end

class FooBarCustomArray < BaseTable
  biggs :postal_address,
        street: [:address_1, :address_empty, :address_nil, :address_2]

  def address_1
    'Address line 1'
  end

  def address_2
    'Address line 2'
  end

  def address_empty
    ''
  end

  def address_nil
    nil
  end
end

describe 'ActiveRecord Class' do

  it 'should include Biggs::ActiveRecordAdapter' do
    expect(FooBar.included_modules).to be_include(Biggs::ActiveRecordAdapter)
  end

  it 'should set class value biggs_value_methods' do
    expect(FooBar.class_eval('biggs_value_methods')).to be_is_a(Hash)
    expect(FooBar.class_eval('biggs_value_methods').size).to be_zero
  end

  it 'should set class value biggs_instance' do
    expect(FooBar.class_eval('biggs_instance')).to be_is_a(Biggs::Formatter)
  end

  it 'should respond to biggs' do
    expect(FooBar).to be_respond_to(:biggs)
  end
end

describe 'ActiveRecord Instance' do

  describe 'Empty' do
    it 'should not have postal_address method' do
      expect(FooBarEmpty.new).not_to be_respond_to(:postal_address)
    end
  end

  describe 'Standard' do
    it 'should have postal_address method' do
      expect(FooBar.new).to be_respond_to(:postal_address)
    end

    it 'should return postal_address on postal_address' do
      expect(FooBar.new.postal_address).to eql("RECIPIENT\nSTREET\nCITY REGION POSTALCODE\nUnited States")
    end
  end

  describe 'Customized Fields' do
    it 'should return address from custom fields on postal_address' do
      expect(FooBarCustomFields.new.postal_address).to eql("RECIPIENT\nSTREET\nPOSTALCODE Hamburg\nGermany")
    end
  end

  describe 'Customized Blank DE Country' do
    it 'should return address wo country on postal_address' do
      expect(FooBarCustomBlankDECountry.new.postal_address).to eql("RECIPIENT\nSTREET\nPOSTALCODE CITY")
    end
  end

  describe 'Customized Method name' do
    it 'should have my_postal_address_method' do
      expect(FooBarCustomMethod.new).to be_respond_to(:my_postal_address_method)
    end

    it 'should return formatted address on my_postal_address_method' do
      expect(FooBarCustomMethod.new.my_postal_address_method).to eql("RECIPIENT\nSTREET\nCITY REGION POSTALCODE\nUnited States")
    end
  end

  describe 'Customized Proc as Param' do
    it 'should return formatted address for unknown-country DEXX' do
      expect(FooBarCustomProc.new.postal_address).to eql("RECIPIENT\nSTREET\nCITY region POSTALCODE\ndexx")
    end
  end

  describe 'Customized array of symbols' do
    it 'should return formatted address with two lines for street' do
      expect(FooBarCustomArray.new.postal_address).to eql("RECIPIENT\nAddress line 1\nAddress line 2\nCITY REGION POSTALCODE\nUnited States")
    end
  end

end
