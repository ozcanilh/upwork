require 'selenium-webdriver'

class BasePage

  attr_reader :driver
  @driver = nil

  def initialize(driver)
    @driver = driver
  end

  def find(locator)
    driver.find_element(locator)
  end

  def size(locator)
    driver.find_elements(locator).size
  end

  # let's wait here to ensure that the page is fully loaded before we move forward
  def click_when_element_found(locator)
    wait = Selenium::WebDriver::Wait.new(:timout => 10)
    element = wait.until {
      driver.find_element(locator)
    }
    element.click
  end

  def wait_for(locator, timeout)
    Selenium::WebDriver::Wait.new(:timeout => timeout).until { @driver.find_element(locator) }
  end

  def element_present?(locator)
    driver.find_element(locator)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    raise 'The Element is not available'
  end

  def element_not_present?(locator)
    driver.find_element(locator)
    raise 'The Element is available'
  rescue Selenium::WebDriver::Error::NoSuchElementError
    true
  end

  def click_on(how, what)
    driver.find_element(how, what).click
  end

  def is_displayed?(locator)
    driver.find_element(locator).displayed?
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def text_of(locator)
    driver.find_element(locator).text
  end

  def type(locator, keyword)
    driver.find_element(locator).send_keys keyword
  end

  def verify_page(title)
    driver.title.include?(title).should == true
  end

end
