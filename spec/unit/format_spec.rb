require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Biggs::Format do
  describe ".find" do
    context "known country with format" do
      subject { Biggs::Format.find("cn") }
      
      it{ should be_kind_of(Biggs::Format) }
      its(:country_name){ should eql("China") }
      its(:iso_code){ should eql("cn") }
      its(:format_string){ should eql("{{recipient}}\n{{street}}\n{{zip}} {{city}} {{state}}\n{{country}}") }
    end
    
    context "known country with unknown format" do
      subject { Biggs::Format.find("af") }
      
      it{ should be_kind_of(Biggs::Format) }
      its(:country_name){ should eql("Afghanistan") }
      its(:iso_code){ should eql("af") }
      its(:format_string){ should eql(nil) }
    end
    
    context "unknown country" do
      subject { Biggs::Format.find("xx") }
      
      it{ should be_kind_of(Biggs::Format) }
      its(:country_name){ should eql(nil) }
      its(:iso_code){ should eql("xx") }
      its(:format_string){ should eql(nil) }
    end
  end
end