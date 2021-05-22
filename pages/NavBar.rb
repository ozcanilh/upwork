require 'selenium-webdriver'
require_relative '../support/BasePage'

class NavBar < BasePage
  #Page Objects
  SEARCH_INPUT = { css: 'input[data-cy=\'search-input\']' }
  SEARCH_OPTIONS_DROPDOWN = { css: 'span[icon-name=\'dropdown-caret\']' }
  SEARCH_OPTION_FREELANCERS = { css: 'a[data-cy=\'menuitem-freelancers\']' }
  SEARCH_BUTTON = { css: 'span[icon-name=\'search\']' }

  # the specific ways to grant access / Create the getter the easy way
  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  # Search keyword which is defined in TestCase class / Step 4-5
  def search_keyword(keyword)
    puts "Click search input."
    click_when_element_found(SEARCH_INPUT)
    puts "Type " + keyword + " keyword in search input."
    type(SEARCH_INPUT, keyword)
    puts "Find 'Hire professionals and agencies'."
    wait_for(SEARCH_OPTION_FREELANCERS, 5)
    puts "Click on the magnifying glass button."
    click_when_element_found(SEARCH_BUTTON)
  end
end