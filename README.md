
# Automation Approach

## Required gems 

source 'http://rubygems.org'

* gem 'selenium-webdriver'

Run the below code to install gems for our testing.
* bundle install

## Framework approach

Framework is created using pageobject model below is the folder structure

* support: utilities and base driver initialization files are added to this folder
* pages: each file in this folder represents a page/section on web application and has all the elements and actions related to the page
* test: test cases are available in folder 

## Running tests

* By default it runs in Chrome browser, you can specify which browser to use as well
    ruby -Ilib:test test/TestCase.rb firefox

* we can pass browser parameters from commandline

## Running tests on different browsers

* we can run tests on different browsers

Example:
 
 Running tests on Chrome on Production environment:  ruby -Ilib:test test/TestCase.rb chrome
 Running tests on Firefox in Production environment: ruby -Ilib:test test/TestCase.rb firefox

## Setup for browser path
* For default, latest version of chrome and geckodriver was added to drivers folder and path was specified for different
  OS. For this reason, or local browsers version should be latest. firstly we have find OS. Easy way; gem 'webdrivers' can be handle these scenario. But according to
  our requirements, it says only 'selenium-webdriver' should be used. If you want to any changes, you can take look below steps.


* If path is required for chrome or firefox;
  Download chromedriver in https://chromedriver.chromium.org/downloads according to your Operating System
  Download geckodriver in https://github.com/mozilla/geckodriver/releases according to your Operating System
  Note: Your local browser version and downloaded driver version should be same.


* After downloaded driver, you have to specify driver path like
  Selenium::WebDriver::Chrome::Service.driver_path="//chrome/chromedriver.exe"
  Selenium::WebDriver::Chrome::Service.driver_path="//firefox/geckodriver.exe"
 
