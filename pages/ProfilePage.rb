require 'selenium-webdriver'
require_relative '../support/BasePage'
require_relative '../pages/SearchResultPage'

class ProfilePage < BasePage #Inheritance
  # Page Objects
  PROFILE_NAME = { css: 'h1[itemprop=\'name\']' }
  PROFILE_TITLE = { xpath: '//section[1]/div[1]/div/div[1]/h2' }
  PROFILE_OVERVIEW = { css: 'span[class=\'text-pre-line break\']' }
  PROFILE_SKILLS = { css: 'ul[class=\'d-flex list-unstyled flex-wrap-wrap\']' }

  # the specific ways to grant access / Creation of getter method easy way
  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  # Compare profile attributes to stored structure (hash_array in Search Result Page) / Step 10
  def profile_attributes_to_stored_structure
=begin
    wait_for(PROFILE_TITLE, 10) #It should be worked but not handled it, for this reason sleep is used
=end
    sleep 5

    @profile_attributes = [] # '@' mean is an instance variable
    name = driver.find_element(PROFILE_NAME).text
    title = driver.find_element(PROFILE_TITLE).text
    skills = driver.find_element(PROFILE_SKILLS).text
    overview = driver.find_element(PROFILE_OVERVIEW).text #New lines should be removed from ui text. Because of comparing to hash array
    puts "Clicked profile name: " + name.to_s
    puts "Clicked profile title: " + title.to_s
    puts "Clicked profile skills: " + skills.to_s.gsub("\n", ' ').squeeze(' ')
    puts "Clicked profile overview: " + overview.to_s.gsub("\n", ' ').squeeze(' ')
    puts
    @profile_attributes.push(name)
    @profile_attributes.push(title)
    @profile_attributes.push(skills)
    @profile_attributes.push(overview)

    @search_result_page = SearchResultPage.new(@driver)
    attribute_results = @search_result_page.get_hash_array.find { |h|
      h["name"] == name &&
      h["title"] == title &&
      h["skills"] == skills &&
      h["overview"] == overview.gsub("\n", ' ').squeeze(' ')}

    attribute_results.length > 0
    puts "Attribute of name, title, overview and skills are same to stored hash array"
  rescue NoMethodError # Exception Handling
    puts "Attribute of name or title or overview or skills are not same to stored hash array"
  end

  # Check whether at least one attribute contains <keyword> / Step 11
  def check_keyword_in_attributes(keyword)
    @profile_attributes.any? { |n| n.include? keyword } ? ( puts "At least one attribute (name, title, skills, overview) " +
    "contain " + keyword + " keyword") : (puts "At least one attribute (name, title, skills, overview) is not contain  "
    + keyword + " keyword")
  end
end
