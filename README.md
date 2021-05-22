
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

If driver 

