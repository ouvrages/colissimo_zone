require "colissimo_zone/version"

module ColissimoZone
  class << self
    def data_filename
      File.expand_path('../data/colissimo_zones.yaml', __FILE__)
    end

    def parse
      require 'yaml'
      YAML.load(File.read(data_filename))
    end

    def all
      @countries ||= parse.map do |country|
        Country.new(country[:code], country[:name], country[:zone], country[:standard_available])
      end
    end

    def find(country_or_code)
      @countries.detect { |country| country.name == country_or_code || country.code == country_or_code }
    end
  end

  class Country
    attr_accessor :code, :name, :zone, :standard_available

    def initialize(code, name, zone, standard_available)
      @code = code
      @name = name
      @zone = zone
      @standard_available = standard_available
    end

  end
end
