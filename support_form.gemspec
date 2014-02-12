$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "support_form/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "support_form"
  s.version     = SupportForm::VERSION
  s.authors     = ["Iain McNulty"]
  s.email       = ["iain@picturk.com"]
  s.homepage    = "http://www.github.com/Picturk"
  s.summary     = "Drop in a support form that sends an email in the backend"
  s.description = "Form sends an email"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.14"
  s.add_development_dependency "pry"
end
