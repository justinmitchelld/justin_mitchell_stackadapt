Before('@ui') do
  require "selenium-webdriver"

  @driver = Selenium::WebDriver.for :chrome
  @driver.manage.timeouts.implicit_wait = 3
end

After('@ui') do
  @driver.quit
end