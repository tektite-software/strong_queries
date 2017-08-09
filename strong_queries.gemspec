$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "strong_queries/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "strong_queries"
  s.version     = StrongQueries::VERSION
  s.authors     = ["Xavier Bick"]
  s.email       = ["fxb9500@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of StrongQueries."
  s.description = "TODO: Description of StrongQueries."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_development_dependency "sqlite3"
end
