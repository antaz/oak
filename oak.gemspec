# frozen_string_literal: true

require_relative "lib/oak/version"

Gem::Specification.new do |spec|
  spec.name = "oak"
  spec.version = Oak::VERSION
  spec.authors = ["Antar Azri"]
  spec.email = ["azantar@proton.me"]
  spec.licenses = ["MIT"]
  spec.summary = "A modular IRC bot written in ruby"
  spec.description = "A modular IRC bot written in ruby"
  spec.required_ruby_version = ">= 2.7"
  spec.files = Dir["lib/*.rb", "lib/**/*.rb", "bin/*"]
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "iirc", "~> 0.6.3"
  spec.add_dependency "nokogiri"
  spec.add_dependency "rss"
  spec.add_dependency "thor", "~> 1.2"
  spec.add_dependency "wikipedia-client"
end
