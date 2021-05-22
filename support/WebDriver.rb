require 'selenium-webdriver'

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
    WebDriver.new(@driver)
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
      options = Selenium::WebDriver::Firefox::Options.new
      options.add_argument('start-maximized')
      @driver = Selenium::WebDriver.for :firefox, options: options
      @driver.manage.delete_all_cookies
      puts "Firefox is started without cookies."
    when 'chrome'
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('start-maximized')
      @driver = Selenium::WebDriver.for :chrome, options: options
      @driver.manage.delete_all_cookies
      puts "Chrome is started without cookies."
    else
      Puts "Browser should be firefox or chrome"
    end
  rescue Selenium::WebDriver::Error::WebDriverError
    raise 'You have to download browser driver and specify driver path with
            Selenium::WebDriver::Chrome::Service.driver_path= *path* for chrome
            Selenium::WebDriver::Firefox::Service.driver_path= *path* for firefox'
  end
end

