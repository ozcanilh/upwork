require 'selenium-webdriver'
require_relative '../support/BasePage'
require_relative '../pages/ProfilePage'

class SearchResultPage < BasePage
  # Page Objects
  ALERT_FIELD = { css: 'div[role=\'alert\']' }
  PROFILE_CARD = { class: 'up-card-section' }
  FIRST_PROFILE_TITLE = { css: 'p[class=\'my-0 freelancer-title\']' }

  # the specific ways to grant access / Create the getter the easy way
  # Accessors are a way to create getter and setter methods without explicitly
  attr_reader :driver

  def initialize(driver)   #Whatever code we want to execute at the start, we can place that code in constructor
    @driver = driver
  end

  # Get all profile attributes after search keyword / Step 6
  def get_profile_search_result(keyword)
    @@hash_result_arr = []
    wait_for(PROFILE_CARD, 5)
    count = size(PROFILE_CARD)
    puts(count.to_s + ' profile is available in 1st result profile page for keyword:' +
                  keyword + '. These are listed below: ')

    (2..count + 1).each { |element|
      hash = Hash.new
      profile_name = driver.find_element(:xpath, '//div[' + (element.to_s) + ']/div[1]/div/div[1]/div/div[2]/button/div')
      profile_title = driver.find_element(:xpath, '//div[' + (element.to_s) + ']/div[1]/div/div[1]/div/div[2]/p')
      profile_overview = driver.find_element(:xpath, '//div[' + (element.to_s) + ']/div[1]/div/div[2]/div[2]/p')
      profile_skills = driver.find_element(:xpath, '//div[' + (element.to_s) + ']/div[2]/div/div[2]')

      hash["name"] = profile_name.text
      hash["title"] = profile_title.text
      hash["overview"] = profile_overview.text
      hash["skills"] = profile_skills.text
      @@hash_result_arr << hash # it can be also .push(hash)
    }
    puts @@hash_result_arr
    puts
  end

  # The longer equivalent of attr_reader / Implicitly returned / "Getter" to return instance variable
  def get_hash_array
     @@hash_result_arr # Can bu used anywhere in class for all class objects
  end

  # Check profile attributes includes searched keyword or not / Step 7
  def check_profile_results_contains_keyword(keyword)
    puts "Checking profile attributes includes searched keyword or not"
    @@hash_result_arr.each do |hash|
      puts "Profile: " + hash["name"].to_s
      hash.each do |key,value|
        value.include?(keyword) ? (puts "Keyword: " + keyword + " is found in "  + key.to_s + ': ' + value.to_s) :
          (puts "Keyword: " + keyword + " is not found in " + key.to_s + ': ' + value.to_s)
      end
      puts
    end

  end

  # Click profile when profile card is loaded / Step 8
  def click_profile
    puts "Click on freelancers title."
    click_when_element_found(FIRST_PROFILE_TITLE)
  end
end
