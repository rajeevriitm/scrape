require 'selenium-webdriver'
require './urls'
driver = Selenium::WebDriver.for :chrome,switches: %w[--start-maximized]
  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
URLS.each do |tag,url|
  driver.navigate.to url
  test = wait.until{driver.find_element(:id,"h")}
driver.action.move_to(test, 5, 5).perform
driver.action.click().perform
gets
end
# driver.action.move_to(test, 380, 150).perform
# driver.action.click().perform
# gets
# driver.action.click().perform
# driver.action.move_to(test, 980, 150).perform
# driver.action.click().perform
# gets
# driver.action.click().perform
# driver.action.move_to(test, 380, 570).perform
# driver.action.click().perform
# gets
# driver.action.click().perform
# driver.action.move_to(test, 910, 570).perform
# driver.action.click().perform
# gets
# driver.action.click().perform
# driver.quit