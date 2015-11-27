$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mailfox/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mailfox"
  s.version     = Mailfox.version
  s.authors     = ["Adam Bahlke", "Michael Rüffer"]
  s.email       = ["develop@hitfoxgroup.com"]
  s.homepage    = "http://hitfoxgroup.com"
  s.summary     = "Quickly plugin Mailchimp, including a CMS-snippet"
  s.description = "An easy-to-implement, reusable newsletter subscribe widget that connects with Mailchimp."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0"

  s.add_development_dependency "sqlite3"
  s.add_dependency "gibbon", "~> 1.1.5"
  s.add_dependency "jquery-rails", ">= 4.0"
  s.add_dependency "email_validator", "1.6.0"
end
