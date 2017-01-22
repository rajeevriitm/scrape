require 'selenium-webdriver'
require "csv"
require './urls'
wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
driver = Selenium::WebDriver.for :chrome,switches: %w[--start-maximized]

left_x = 390
right_x = 900
top_y = 150
bottom_y = 570
step = 8
x_count =(right_x - left_x)/step
y_count = (bottom_y - top_y)/step
URLS.each do |tag,url|
  CSV.open(tag.to_s + ".csv","w+") do |csv|
    driver.navigate.to url
    test = wait.until{driver.find_element(:id,"h")}
    jds = wait.until{driver.find_element(:class,"jd")}
    sleep 2
    script= "var elems = document.getElementsByClassName('jd') ; while(elems[0]) { elems[0].parentNode.removeChild(elems[0]); }"
    driver.execute_script(script)
    driver.action.move_to(test, 300, 150).perform
    driver.action.click().perform
    x_count.times do |x|
      y_count.times do |y|
        driver.action.move_to(test, 5, 5).perform
        driver.action.click.perform
        driver.action.move_to(test, left_x+step*x, top_y+step*y).perform
        elem=wait.until{driver.find_element(:class,"yy")}
        value= elem.text
        sleep 0.1
        driver.action.click.perform
        begin
          elem3=wait.until{driver.find_element(:css,'#p a')}
        rescue
          gets
          elem3=wait.until{driver.find_element(:css,'#p a')}
        end
        location= elem3.text
        puts "#{location} - #{value}"
        csv << [location,value]
      end
    end
  end
end
driver.quit