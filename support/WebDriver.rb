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
  end

  def implicit_wait
    @driver.manage.timeouts.implicit_wait = 50000
  end

  def page_load
    @driver.manage.timeouts.page_load = 50000
  end

  def start_browser(browser)

    if Selenium::WebDriver::Platform.linux?
      driverChrome = "chromedriverLinux"
      driverFirefox = "geckodriverLinux.exe"
    elsif Selenium::WebDriver::Platform.mac?
      driverChrome = "chromedriverMac"
      driverFirefox = "geckodriverMac.exe"
    elsif Selenium::WebDriver::Platform.windows?
      driverChrome = "chromedriverWin.exe"
      driverFirefox = "geckodriverWin.exe"
    else
        raise NotImplementedError, 'Your OS is not supported by webdrivers gem.'
    end

    case browser
    when 'firefox'
      geckodriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),
                                   "upwork/drivers", driverFirefox)
      Selenium::WebDriver::Chrome::Service.driver_path=geckodriver_path
      @driver = Selenium::WebDriver.for :firefox
      @driver.manage.window.maximize
      @driver.manage.delete_all_cookies
      puts "Firefox is started without cookies."
    when 'chrome'
      chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),
                                    "upwork/drivers", driverChrome)
      Selenium::WebDriver::Chrome::Service.driver_path=chromedriver_path
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

