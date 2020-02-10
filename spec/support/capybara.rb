# frozen_string_literal: true

# Configure Capybara for rspec system tests
require 'capybara/rspec'

Capybara.server = :puma
Capybara.asset_host = 'http://localhost:3000'

# Not currently being used
# Capybara.register_driver :selenium_chrome do |app|
# Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

Capybara.javascript_driver = :selenium_chrome

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  # Not currently being used
  # config.before(:each, type: :system, js: true) do
  # driven_by :selenium_chrome_headless
  # end
end

# Allow the use of screenshot_and_save_page or screenshot_and_open_image in RSpec system tests
require 'capybara-screenshot/rspec'
# Disable auto screenshots since it doesn't work on rails 5.1 and up anyway.
Capybara::Screenshot.autosave_on_failure = false
