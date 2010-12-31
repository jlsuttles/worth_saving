source 'http://rubygems.org'

gem 'rails', '3.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'haml'

group :cucumber do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'spork'
  gem 'launchy'
end

group :test do
  gem 'rspec-rails'
end

group :test, :cucumber, :development do
  gem 'factory_girl_rails'
  gem 'rails3-generators'
  gem 'ruby-debug', '0.10.4'
  gem 'mocha'
end
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
