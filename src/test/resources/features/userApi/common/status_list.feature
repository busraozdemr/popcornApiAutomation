Feature: Status List

  Background:
    * url userApiUrl
    * header accept = '*/*'

  Scenario: Status List - Success scenario
    Given path '/Common/StatusList'
    When method GET
    Then status 200
    Then print 'response --> ', response

    Then match $[0].isDefault == false
    Then match $[0].name == "Passive"
    Then match $[0].id == 0
    Then match $[0].enumName == "UnPublished"

    Then match $[1].isDefault == false
    Then match $[1].name == "Active"
    Then match $[1].id == 1
    Then match $[1].enumName == "Published"

    Then match $[2].isDefault == true
    Then match $[2].name == "Archived"
    Then match $[2].id == 2
    Then match $[2].enumName == "Junk"

    #type control in array
    Then match response[*].isDefault contains ["#boolean"]
    Then match response[*].name contains ["#string"]
    Then match response[*].enumName contains [#string]
    Then match response[*].id contains [#number]