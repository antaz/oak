# frozen_string_literal: true

require_relative "lib/oak/version"

Gem::Specification.new do |spec|
  spec.name = "oak"
  spec.version = Oak::VERSION
  spec.authors = [""]
  spec.email = [""]
  spec.summary = ""
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/*.rb", "lib/**/*.rb", "bin/*.rb"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "iirc"
  spec.add_dependency "thor"
  spec.add_dependency "uri"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
