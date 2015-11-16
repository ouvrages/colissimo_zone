require 'spec_helper'

describe ColissimoZone do

  it "respond_to #all" do
    expect(ColissimoZone.respond_to?(:all)).to be(true)
  end

  describe "#all" do
    it "returns collection of ColissimoZone::Country" do
      expect(ColissimoZone.all.all? { |country| country.is_a?(ColissimoZone::Country) }).to be(true)
    end
  end

  describe "#find" do
    it "returns the right Country object" do
      expect(ColissimoZone.find("MQ")).to eq(ColissimoZone.all.detect { |country| country.code == "MQ" })
      expect(ColissimoZone.find("Albanie")).to eq(ColissimoZone.all.detect { |country| country.name == "Albanie" })
    end
  end

  describe "ColissimoZone::Country" do
    it "responds to code" do
      expect(ColissimoZone.all.first.respond_to?(:code)).to be(true)
    end

    it "responds to name" do
      expect(ColissimoZone.all.first.respond_to?(:name)).to be(true)
    end

    it "responds to zone" do
      expect(ColissimoZone.all.first.respond_to?(:zone)).to be(true)
    end

    it "responds to standard_available" do
      expect(ColissimoZone.all.first.respond_to?(:standard_available)).to be(true)
    end
  end

end
