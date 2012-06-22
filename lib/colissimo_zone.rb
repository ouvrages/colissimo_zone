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
      parse
    end
  end
end
