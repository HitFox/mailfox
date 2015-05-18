$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mailpimp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mailpimp"
  s.version     = Mailpimp::VERSION
  s.authors     = ["HitFox"]
  s.email       = ["develop@hitfoxgroup.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Mailpimp."
  s.description = "TODO: Description of Mailpimp."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_dependency "rails_config", "~> 0.4"
  s.add_dependency "gibbon", "~> 1.1.5"
  s.add_dependency "jquery-rails", ">= 4.0"
end
