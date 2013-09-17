require 'cucumber/rails'

require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'rspec/rails'
DatabaseCleaner.strategy = nil


#Include all factory files from spec/factories
# Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

require File.expand_path("spec/helpers/datahelper.rb")
require File.expand_path("spec/helpers/comparesunsspechelper.rb")


Capybara.run_server = false
Capybara.server_port = 31337
Capybara.default_selector = :css
Capybara.default_driver = :selenium

ActionController::Base.allow_rescue = false

#begin
#  DatabaseCleaner.strategy = :transaction
#rescue NameError
#  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
#end

  class << Cucumber::Rails::World
    def use_transactional_fixtures
      false
    end
    def use_transactional_fixtures=(other)
      # do nothing
    end
  end

if (ENV["HEADLESS"])
  puts "in headless"
  require 'headless'
  @headless = Headless.new(display: 100, reuse: true, :destroy_at_exit => false)
  @headless.start
end

at_exit do
  #this is creating problems while running parallel headless tests. find a better solution
  #@headless.destroy if ENV["HEADLESS"] && !@headless.nil?
end
#Cucumber::Rails::Database.javascript_strategy = :truncation

After do |scenario|
  if scenario.failed?
    file_name = SCREENSHOT_FILE_PATH+"screenshot_"+random_name+".png"
    save_error_screenshot(file_name)
  end
end
