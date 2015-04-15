
  selenium_browser = if ENV['SELENIUM_BROWSER'] == 'firefox'
    :selenium
  elsif ENV['WEBDRIVER'] == 'accessible'
    require 'capybara/accessible'
  elsif ENV['SELENIUM_BROWSER']
    ENV['SELENIUM_BROWSER'].to_sym
  else
    :poltergeist
  end

  if selenium_browser == :poltergeist
    require 'capybara/poltergeist'
  else
    Capybara.register_driver selenium_browser do |app|
      Capybara::Selenium::Driver.new(app, browser: :firefox)
    end
  end

  # Run Selinum on a "known" port (prevents some deadlocks) and allows usage of
  # dev tools such as vagrant and docker
  Capybara.configure do |config|
    config.app_host = 'http://localhost:3001'
    config.run_server = true
    config.server_port = 3001
    config.javascript_driver = selenium_browser
  end

  # Extend AJAX wait time out
  Capybara.default_wait_time = 15

  # # Take screenshots when feature specs fail
  require 'capybara-screenshot/rspec'
  Capybara::Screenshot.prune_strategy = :keep_last_run
  Capybara.save_and_open_page_path = "tmp/capybara"

  # Resize selenium browser window to avoid Selenium::WebDriver::Error::MoveTargetOutOfBoundsError errors
  RSpec.configure do |config|
    config.before(:each) do
      page.driver.browser.manage.window.resize_to(1200, 800)  if Capybara.current_driver == :chrome
    end

    # If on before reload is set, kill it to prevent test state leakage.
    config.after(:each, js: true) do
      page.execute_script('window.onbeforeunload = null;')
    end

    if ENV['WEBDRIVER'] == 'accessible'
      config.around(:each, inaccessible: true) do |example|
        Capybara::Accessible.skip_audit { example.run }
      end
    end

    config.append_after(:each,  type: :feature) do
      Capybara.reset_sessions!
    end

    config.append_after(:each,  type: :feature) { page.driver.reset! }
  end
