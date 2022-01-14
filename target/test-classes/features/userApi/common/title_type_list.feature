Feature: Title Type List

  Background:
    * url userApiUrl
    * header accept = '*/*'

  Scenario: Title Type List - Success Scenario
    Given path '/Common/TitleTypeList'
    When method GET
    Then status 200
    Then print 'response --> ', response

    Then match $[0].isDefault == true
    Then match $[0].name == "Home"
    Then match $[0].displayOrder == 0
    Then match $[0].id == 10
    Then match $[0].enumName == "Home"

    Then match $[1].isDefault == false
    Then match $[1].name == "Work"
    Then match $[1].displayOrder == 0
    Then match $[1].id == 20
    Then match $[1].enumName == "Work"

    Then match $[2].isDefault == false
    Then match $[2].name == "Other"
    Then match $[2].displayOrder == 0
    Then match $[2].id == 30
    Then match $[2].enumName == "Other"

    #type control in array
    Then match response[*].isDefault contains ["#boolean"]
    Then match response[*].name contains ["#string"]
    Then match response[*].displayOrder contains ["#number"]
    Then match response[*].enumName contains [#string]
    Then match response[*].id contains [#number]