Feature: Custom templates
  When I run Eyemask with a template
  I want to receive the right output for that template
  So I can produce custom documentation types

  Scenario: Run Eyemask supplying a template
    Given a file named "cucumber_output.json" with:
      """
        []
      """
    And a file named "my_template.html" with:
      """
        <html>
          <body>
            <h1>{{ title }}</h1>
          </body>
        </html>
      """
    When I run Eyemask on "cucumber_output.json" with the template: "my_template.html"
    Then the exit status should be 0
    And the output should contain:
      """
      <h1>Specification</h1>
      """