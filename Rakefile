#!/usr/bin/env rake
require "bundler/gem_tasks"

task :update do
  require "rubygems"
  require "bundler/setup"
  require 'watir-webdriver'
  require "watir-webdriver/wait"
  require 'nokogiri'
  require 'yaml'
  require 'bigdecimal'
  
  data = []
  
  zone_prices = {
    BigDecimal("12.70") => "1",
    BigDecimal("15.20") => "2",
  }
  
  browser = Watir::Browser.new
  browser.goto 'http://www.colissimo.fr/'
  browser.link(:text => "Envoyer un colis").click
  browser.link(:text => "Colissimo Outre-mer").click
  browser.link(:text => "Calculer le tarif").click
  
  country_select = browser.select_list(:name => 'paysDestinationFicheProduit')
  Watir::Wait.until { country_select.options.size > 0 }
  doc = Nokogiri::HTML(country_select.html)
  options = doc.css("option")
  options.shift
  countries = options.map { |option| [option["value"], option.text] }

  countries.each do |code, name|
    country_select.select name
    
    solution_select = browser.select_list(:name => 'solutionAffranchissement')
    solution_select.when_present.select "Guichet"
    browser.text_field(:name => 'poids').when_present.set '1'
    Watir::Wait.until { browser.select_list(:name => 'natureEnvoi').options.size > 0 }
    if browser.select_list(:name => 'natureEnvoi').option(:text => "Standard").present?
      select_option = "Standard"
      price_diff = 0
      standard_available = true
    else
      select_option = "Non standard"
      price_diff = 6
      standard_available = false
    end
    browser.select_list(:name => 'natureEnvoi').select select_option
    browser.image(:src => "img/misc/boutonCalculTarif.gif").when_present.click
    price_text = browser.p(:class => "price").when_present.text
    price, = price_text.scan(/(\d+\.\d{2})/).first
    if price
      price = BigDecimal(price) - price_diff
      zone = zone_prices[price]
      puts "Zone not found for price #{price.to_s} on #{name}" unless zone
    else
      puts "No price on #{name}"
      zone = nil
    end
    country_data = {
      name: name,
      code: code,
      zone: zone,
      standard_available: standard_available,
    }
    p country_data
    data << country_data
  end

  
  
  zone_prices = {
    BigDecimal("16.15") => "A",
    BigDecimal("19.80") => "B",
    BigDecimal("23.20") => "C",
    BigDecimal("26.40") => "D",
  }
  browser.goto 'http://www.colissimo.fr/'
  browser.link(:text => "Envoyer un colis").click
  browser.link(:text => "Colissimo International").click
  browser.link(:text => "Calculer le tarif").click
  solution_select = browser.select_list(:name => 'solutionAffranchissement')
  solution_select.select "Guichet"
  country_select = browser.select_list(:name => 'paysDestination')
  Watir::Wait.until { country_select.options.size > 0 }
  doc = Nokogiri::HTML(country_select.html)
  options = doc.css("option")
  options.shift
  countries = options.map { |option| [option["value"], option.text] }
  
  countries.each do |code, name|
    country_select.select name
    browser.text_field(:name => 'poids').when_present.set '1'
    Watir::Wait.until { browser.select_list(:name => 'natureEnvoi').options.size > 0 }
    if browser.select_list(:name => 'natureEnvoi').option(:text => "Standard").present?
      select_option = "Standard"
      price_diff = 0
      standard_available = true
    else
      select_option = "Non standard"
      price_diff = 6
      standard_available = false
    end
    
    browser.select_list(:name => 'natureEnvoi').select select_option
    browser.image(:src => "img/misc/boutonCalculTarif.gif").when_present.click
    price_text = browser.p(:class => "price").when_present.text
    price, = price_text.scan(/(\d+\.\d{2})/).first
    if price
      price = BigDecimal(price) - price_diff
      zone = zone_prices[price]
      puts "Zone not found for price #{price.to_s} on #{name}" unless zone
    else
      puts "No price on #{name}"
      zone = nil
    end
    country_data = {
      name: name,
      code: code,
      zone: zone,
      standard_available: standard_available,
    }
    p country_data
    data << country_data
  end
  
  File.open("lib/data/colissimo_zones.yaml", "w") do |f|
    f.write data.to_yaml
  end
end
