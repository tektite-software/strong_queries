$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "strong_queries/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "strong_queries"
  s.version     = StrongQueries::VERSION
  s.authors     = ["Xavier Bick"]
  s.email       = ["fxb9500@gmail.com"]
  s.homepage    = "https://github.com/tektite-software/strong_queries"
  s.summary     = "Better, stronger API queries for Rails"
  s.description = "A GraphQL-inspired querying plugin for Rails with usage similar to strong_parameters."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4"

  s.add_development_dependency "sqlite3"
end
