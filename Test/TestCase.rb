require 'selenium-webdriver'
require_relative '../pages/NavBar'
require_relative '../pages/SearchResultPage'
require_relative '../pages/ProfilePage'
require_relative '../support/WebDriver'

$args = ARGV.dup # A global variable for browser
class UpworkTest < WebDriver #Inheritance

  def setup
    visitpage($args[0])
    @search_result = SearchResultPage.new(@driver)
    @profile = ProfilePage.new(@driver)
    @keyword = "Ruby"
  end

  def search_keyword
    @navbar = NavBar.new(@driver)
    @navbar.search_keyword @keyword
  end

  def check_profile_result_contains_keyword
    @search_result.get_profile_search_result(@keyword)
    @search_result.check_profile_results_contains_keyword(@keyword)
  end

  def click_profile
    @search_result.click_profile
  end

  def profile_attributes_to_stored_structure
    @profile.profile_attributes_to_stored_structure
  end

  def check_keyword_in_attributes
    @profile.check_keyword_in_attributes(@keyword)
  end
end

def teardown
  @driver = Selenium::WebDriver.for :$args[0]
  @driver.close # It closes the the browser window on which the focus is set.
  @driver.quit # It basically calls driver.dispose method which in turn closes all the browser windows and ends the WebDriver session gracefully.
end

@upworktest = UpworkTest.new(@driver)
@webdriver = WebDriver.new(@driver)
def run
  @upworktest.setup
  yield
  teardown
end

run {
  @upworktest.search_keyword # Step 5
  @upworktest.check_profile_result_contains_keyword # Step 6 and 7
  @upworktest.click_profile # Step 8
  @upworktest.profile_attributes_to_stored_structure # Step 10
  @upworktest.check_keyword_in_attributes # Step 11
}

