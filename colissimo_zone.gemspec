# -*- encoding: utf-8 -*-
require File.expand_path('../lib/colissimo_zone/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ouvrages"]
  gem.email         = ["contact@ouvrages-web.fr"]
  gem.description   = %q{Country zones for the French postal service Colissimo}
  gem.summary       = %q{List of countries with Colissimo zone}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "colissimo_zone"
  gem.require_paths = ["lib"]
  gem.version       = ColissimoZone::VERSION

  gem.add_development_dependency 'rspec', '~> 3.0'
end
