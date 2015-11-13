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
    BigDecimal("13.85") => "1",
    BigDecimal("16.55") => "2",
  }

  browser = Watir::Browser.new
  browser.driver.manage.timeouts.implicit_wait = 60
  browser.goto 'http://www.colissimo.fr/portail_colissimo/ficheProduitAction.do?f=FR-6'

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
    sleep 1
    browser.image(:src => "http://1.1.1.3/bmi/www.colissimo.fr/portail_colissimo/img/misc/boutonCalculTarif.gif").when_present.click
    price_text = browser.p(:class => "price").when_present.text
    price, = price_text.scan(/(\d+\.\d{2})/).first
    if price
      price = BigDecimal(price) - price_diff
      zone = zone_prices[price]
      puts "Zone not found for price #{price.to_s("F")} on #{name}" unless zone
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
    BigDecimal("14.85") => "A",
    BigDecimal("19.35") => "B",
    BigDecimal("26.30") => "C",
  }
  browser.goto 'http://www.colissimo.fr/portail_colissimo/ficheProduitAction.do?f=FR-9'
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
    sleep 1
    browser.image(:src => "http://1.1.1.3/bmi/www.colissimo.fr/portail_colissimo/img/misc/boutonCalculTarif.gif").when_present.click
    price_text = browser.p(:class => "price").when_present.text
    price, = price_text.scan(/(\d+\.\d{2})/).first
    if price
      price = BigDecimal(price) - price_diff
      zone = zone_prices[price]
      puts "Zone not found for price #{price.to_s("F")} on #{name}" unless zone
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

  browser.close
end
