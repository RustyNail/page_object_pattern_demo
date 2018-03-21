require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.include Capybara::DSL
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chrome_options: {
        args: %w[window-size=1600,800 headless disable-gpu no-sandbox]
      }
    )
  )
end

Capybara.configure do |capybara|
  capybara.app_host = 'http://example.selenium.jp'
  capybara.default_driver = :selenium
  capybara.ignore_hidden_elements = false
end

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

Dir[File.join(__dir__, './pages/**/*.rb')].each { |f| require f }
