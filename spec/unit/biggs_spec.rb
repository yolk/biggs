require File.join(File.dirname(__FILE__), '..', 'spec_helper')

FAKE_ATTR_WITH_REGION = { region: 'REGION', city: 'CITY', postalcode: 12_345, street: 'STREET', recipient: 'MR. X' }
FAKE_ATTR_WO_REGION = { city: 'CITY', postalcode: 12_345, street: 'STREET', recipient: 'MR. X' }

describe Biggs::Formatter, 'with defaults' do

  before { @biggs = Biggs::Formatter.new }

  it 'should format to us format' do
    expect(@biggs.format('us', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\nCITY REGION 12345\nUnited States")
  end

  it 'should format to de format' do
    expect(@biggs.format('de', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nGermany")
  end

  it 'should format to british format' do
    expect(@biggs.format('gb', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\nCITY\nREGION\n12345\nUnited Kingdom")
  end

  it 'should format to fr format' do
    expect(@biggs.format('fr', FAKE_ATTR_WO_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nFrance")
  end

  it 'should format to fr format if country_code unknown and there is no REGION given' do
    expect(@biggs.format('unknown', FAKE_ATTR_WO_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nunknown")
  end

  it 'should format to us format if country_code unknown and there is no REGION given' do
    expect(@biggs.format('unknown', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\nCITY REGION 12345\nunknown")
  end

  it 'should format to no(rwegian) format' do
    expect(@biggs.format('no', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nNorway")
  end

  it 'should format to NC format' do
    expect(@biggs.format('nc', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nNew Caledonia")
  end

  it 'should use country name if Country is known but format not' do
    expect(@biggs.format('af', FAKE_ATTR_WO_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nAfghanistan")
  end

  it 'should use ISO Code if Country is unknown' do
    expect(@biggs.format('xx', FAKE_ATTR_WO_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nxx")
  end

end

describe Biggs, 'with options' do

  describe 'blank_country_on de' do
    before { @biggs = Biggs::Formatter.new(blank_country_on: 'de') }

    it "should have blank country in 'de' address" do
      expect(@biggs.format('de', FAKE_ATTR_WO_REGION)).to eql("MR. X\nSTREET\n12345 CITY")
    end

    it "should have country in 'fr' address" do
      expect(@biggs.format('fr', FAKE_ATTR_WO_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nFrance")
    end

  end

  describe 'blank_country_on multiple (US,de)' do
    before { @biggs = Biggs::Formatter.new(blank_country_on: %w(US de)) }

    it "should have blank country in 'us' address" do
      expect(@biggs.format('us', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\nCITY REGION 12345")
    end

    it "should have country in 'fr' address" do
      expect(@biggs.format('fr', FAKE_ATTR_WITH_REGION)).to eql("MR. X\nSTREET\n12345 CITY\nFrance")
    end

  end

end
