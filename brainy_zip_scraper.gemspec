# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brainy_zip_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "brainy_zip_scraper"
  spec.version       = BrainyZipScraper::VERSION
  spec.authors       = ["Eric Berry"]
  spec.email         = ["cavneb@gmail.com"]
  spec.summary       = "Save zip code data to CSV"
  spec.description   = "Save zip code data to CSV"
  spec.homepage      = "https://github.com/cavneb/brainy_zip_scraper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_dependency "ruby-progressbar", "~> 1.6.1"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
