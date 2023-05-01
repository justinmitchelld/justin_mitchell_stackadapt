# Loads navigation yml based on the provided application (has built in error handling).
# Uses the webdriver instance to navigate to the application landing page.
# Navigational URLs are stored in a yml for easy access, addition and modification.
# Additional error handling on yml attribute existence.
When(/^I navigate to the (StackAdapt) web application (landing) page$/) do |application, page_name|
  @url = YAML.load_file("config/navigation/#{application.downcase}.yml")

  begin
    @driver.navigate.to @url[page_name]
  rescue
    raise "Attribute '#{page_name}' does not exist in '#{application}' navigation yml."
  end
end

Then(/^I arrive at the (landing|request_demo) page$/) do |page_name|
  raise "page_name '#{page_name}' does not exist in target yml." if @url[page_name].nil?

  # Assertion: Current Position to Expected Position.
  expect(@driver.current_url).to end_with(@url[page_name])
end