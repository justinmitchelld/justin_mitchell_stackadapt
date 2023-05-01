When(/^I click on the (Request a Demo) button$/) do |button|
  # Locate button element & click.
  element = @driver.find_element(:link_text, button)
  @driver.execute_script('arguments[0].click()', element)
end

When(/^I provide the following information for (request_demo) form:$/) do |_page, table|
  elements = []

  # Locate form inputs and build array for full form clear.
  elements << first_name = @driver.find_elements(:id, 'first_name').first
  elements << last_name = @driver.find_elements(:id, 'last_name').first
  elements << email = @driver.find_elements(:id, 'email').first
  elements << phone = @driver.find_elements(:id, 'phone').first
  elements << company_name = @driver.find_elements(:id, 'company_name').first
  elements << job_title = @driver.find_elements(:id, 'job_title').first

  elements << company_type = @driver.find_elements(:id, 'company_type').first
  elements << country = @driver.find_elements(:id, 'country').first
  elements << region = @driver.find_elements(:id, 'region').first
  elements << province = @driver.find_elements(:id, 'province').first
  elements << state = @driver.find_elements(:id, 'state').first

  # Out of scope
  elements << _company_size = @driver.find_elements(:id, 'company_size').first
  elements << _budget = @driver.find_elements(:id, 'budget').first
  elements << _intention = @driver.find_elements(:id, 'intention').first

  # Not required to be cleared due to hash[:gdpr_consent] logic.
  gdpr_label = @driver.find_element(:css, 'label[for="gdpr_consent"]')
  gdpr_consent = @driver.find_elements(:id, 'gdpr_consent').first

  # Clear all elements to ensure clean starting point.
  FormHelper.clear_elements(elements)

  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :phone, :company_name, :job_title, :company_type, :company_size, :country, :region, :budget, :intention, :gdpr_consent]
  table.hashes.each do |hash|

    # Set values from dataset.
    first_name.send_keys hash[:first_name]
    last_name.send_keys hash[:last_name]
    email.send_keys hash[:email]
    phone.send_keys hash[:phone]
    company_name.send_keys hash[:company_name]
    job_title.send_keys hash[:job_title]
    company_type.send_keys hash[:company_type]
    country.send_keys hash[:country]

    # Handle combinations of region/province/state.
    region.send_keys hash[:region] if region.displayed?
    province.send_keys hash[:region] if province.displayed?
    state.send_keys hash[:region] if state.displayed?

    # Out of scope.
    # company_size.send_keys hash[:company_size]
    # budget.send_keys hash[:budget]
    # intention.send_keys hash[:intention]
    #
    ## Options to implement:
    ## 1. Input direct match to dropdown values from data set. Ie: '10 to 100'
    ## 2. Create a method in form_helper that maps values to ranges.

    # Set checkbox to appropriate state based on feature file dataset boolean.
    case hash[:gdpr_consent].downcase
    when 'true'
      gdpr_label.click unless gdpr_consent.selected?
    when 'false'
      gdpr_label.click if gdpr_consent.selected?
    else
      # Default to unchecked if an unexpected input is provided from dataset.
      puts "form_check Unhandled input. Must be 'true' or 'false'. Defaulting to unchecked."
      gdpr_label.click if gdpr_consent.selected?
    end
  end
end

When(/^I click the submit button$/) do
  # Locate button element & click.
  @driver.find_element(:xpath, "//button[text()='Submit']").click
end

Then(/^(request_demo) form attributes will be in the following state:$/) do |page, table|
  # Read mapped locators from yml.
  locators = YAML.load_file("config/stack_adapt/locators/#{page}/locators.yml")

  # table is a table.hashes.keys # => [:attribute, :feedback]
  table.hashes.each do |hash|
    begin
      # Locate the field error text element.
      error_element = @driver.find_element(:xpath, locators['errors'][hash['attribute']])

      # Read the expected state from the data table.
      state = hash['feedback'].empty? ? false : true

      # Assert expected error text for field is displayed.
      # Add a required field check if scope allows - element.required?
      expect(error_element.displayed?).to eql(state), "#{hash['attribute']} invalid-feedback"
    rescue Selenium::WebDriver::Error::InvalidSelectorError
      raise "Attribute '#{hash['attribute']}' does not exist in locators.yml"
    rescue NoMethodError
      raise "yml path for '#{hash['attribute']}' was not found."
    end
  end
end