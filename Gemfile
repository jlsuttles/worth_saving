source 'http://rubygems.org'

gem 'rails', '3.1.3'
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
  gem 'mocha'
  gem 'ruby-debug19', :require => 'ruby-debug'
end
