source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

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
