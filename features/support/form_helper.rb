class FormHelper
  # Clear form using an array of elements.
  def self.clear_elements(elements)
    elements.each do |element|
      # Logic to handle combination presence of country/region/state/province.
      if element.displayed? && element.enabled?
        case element.tag_name
        when 'input'
          # Clear text inputs.
          element.clear
        when 'select'
          # Clear dropdowns to default select.
          Selenium::WebDriver::Support::Select.new(element).select_by(:text, "")
        else
          puts "Unexpected element '#{element.tag_name}' was not cleared."
        end
      end
    end
  end
end