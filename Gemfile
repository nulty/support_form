source "https://rubygems.org"

# Declare your gem's dependencies in support_form.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
group :development, :test do
  gem "selenium-webdriver"
  # gem "capybara-webkit"
  gem "capybara", "~> 2.1"
  gem "database_cleaner", git: "https://github.com/bmabey/database_cleaner.git", branch: "master"
end

group :assets do
  gem 'uglifier'
end