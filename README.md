# ColissimoZone

Country zones for the French postal service Colissimo

Liste des pays distribués par Colissimo avec leur zone.

Certains pays n'ont pas l'option "Standard". Ils sont marqués avec la valeur standard_available à faux.

Les données ont été récupérées automatiquement sur le site de Colissimo. Elles peuvent être mises à jour avec "rake update".

## Installation

Add this line to your application's Gemfile:

    gem 'colissimo_zone'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install colissimo_zone

## Usage

Examples:

    ColissimoZone.all.each do |country|
      puts "#{country[:name]} (#{country[:code]): #{country[:zone]}"
    end

    ColissimoZone.all.select { |country| country[:standard_available] }.map { |country| country[:name] }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
