Justin Mitchell - StackAdapt Automation Assignment

Feel free to use any automation frameworks or languages you feel comfortable with; this can be
accomplished with native Javascript if one so chooses to.
Submit a script that starts at our main page (https://www.stackadapt.com/) and navigates to our
request a demo page (via the blue button in the top right), fills in the form with only the following
information, and submits it:

```
First name: Jane
Last name: Doe
Business Email: jane.doe@advertising.com
Phone number: +1112223344
Company name: advertising.com
Job title: Chief Executive Officer
Company type: Publisher
Country: Canada
Province: Ontario
I agree to the storing and processing of my data in order to answer and process my request: No
(Unchecked)
```

Feature 1: Demo Request Form
```
1. Navigate to https://www.stackadapt.com/
2. Click 'Request a Demo' button
3. Clear the form (not required due to form defaults, but good practice)
4. Input provided form data
5. Click Submit button
6. Validate expected results & error messages
```

Additional notes:
```
1. Webdriver instance is created before scenarios tagged @ui in support/hooks.rb
2. Webdriver instance is closed after scenarios tagged @ui in support/hooks.rb
```
Console Execution:
```
cucumber features -t [tag]
```
Included Tags:
```
@ui
@request_demo
```
![stack_adapt](https://user-images.githubusercontent.com/125304857/235411307-30c5b3f3-a91f-47bd-9d3a-78c0807578b9.JPG)
