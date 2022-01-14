Feature: Rider Status List

  Background:
    * url userApiUrl
    * header accept = '*/*'

  Scenario: Rider Status List - Success Scenario
    Given path '/Common/RiderStatusList'
    When method GET
    Then status 200
    Then print 'response --> ', response

    Then match $[0].isDefault == true
    Then match $[0].name == "be.user.enums.riderstatus.active"
    Then match $[0].displayOrder == 0
    Then match $[0].id == 1
    Then match $[0].enumName == "Active"

    Then match $[1].isDefault == false
    Then match $[1].name == "be.user.enums.riderstatus.inactive"
    Then match $[1].displayOrder == 0
    Then match $[1].id == 2
    Then match $[1].enumName == "Inactive"

      #type control in array
    Then match response[*].isDefault contains ["#boolean"]
    Then match response[*].name contains ["#string"]
    Then match response[*].displayOrder contains ["#number"]
    Then match response[*].enumName contains [#string]
    Then match response[*].id contains [#number]