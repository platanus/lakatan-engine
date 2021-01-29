$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "lakatan/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "lakatan"
  spec.version     = Lakatan::VERSION
  spec.authors     = ["Platanus", "Leandro Segovia"]
  spec.email       = ["rubygems@platan.us", "ldlsegovia@gmail.com"]
  spec.homepage    = "https://github.com/platanus/lakatan_engine"
  spec.summary     = "Rails engine to play with https:/lakatan.dev"
  spec.description = "Rails engine to play with https:/lakatan.dev"
  spec.license     = "MIT"

  spec.files = `git ls-files`.split($/).reject { |fn| fn.start_with? "spec" }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files = Dir["spec/**/*"]

  spec.add_dependency "rails", "~> 6.0"

  spec.add_dependency "activeresource"
  spec.add_dependency "require_all"

  spec.add_development_dependency "annotate"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-rails"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rubocop", "0.66"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
