source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
gem "therubyracer", :require => 'v8'

gem 'pg', :require => 'pg'

gem 'xml-simple', :require => 'xmlsimple'

group :development, :test do
  gem 'factory_girl_rails'                        # use factories instead of fixtures
  gem 'faker'                                     # easily create fake data for tests
  gem 'rspec-rails'                               # test framework
  gem "cucumber-rails", "~> 1.0", require: false  # integration test framework
  gem 'simplecov'                                 # test coverage report
  gem 'json_spec'                                 # easier testing of JSON
  gem 'database_cleaner'                          # manage DB between tests
  gem 'mongoid-rspec'                             # rspec matchers for mongoid
  gem 'autotest-rails'
end