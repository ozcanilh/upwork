require 'selenium-webdriver'
require 'webdrivers/chromedriver'
require 'webdrivers/geckodriver'

class WebDriver

  @driver = nil

  def initialize (driver)
    @driver = driver
  end

  def visitpage (browser)
    start_browser(browser)
    @driver.navigate.to('http://www.upwork.com')
    implicit_wait
    page_load
  end

  def implicit_wait
    @driver.manage.timeouts.implicit_wait = 50000
  end

  def page_load
    @driver.manage.timeouts.page_load = 50000
  end

  def start_browser(browser)
    case browser
    when 'firefox'
      @driver = Selenium::WebDriver.for :firefox
      @driver.manage.window.maximize
      @driver.manage.delete_all_cookies
      puts "Firefox is started without cookies."
    when 'chrome'
      @driver = Selenium::WebDriver.for :chrome
      @driver.manage.window.maximize
      @driver.manage.delete_all_cookies
      puts "Chrome is started without cookies."
    else
      puts "Browser should be firefox or chrome. For this reason browser set to Chrome as a default"
      @driver = Selenium::WebDriver.for :chrome
      @driver.manage.window.maximize
      @driver.manage.delete_all_cookies
      puts "Chrome is started without cookies."
    end
  rescue Selenium::WebDriver::Error::WebDriverError
    raise 'You have to download browser driver and specify driver path like
            Selenium::WebDriver::Chrome::Service.driver_path= *path* for chrome
            Selenium::WebDriver::Firefox::Service.driver_path= *path* for firefox'
  end
end

