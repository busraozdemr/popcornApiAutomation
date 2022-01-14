Feature: User Status List

  Background:
    * url userApiUrl
    * header accept = '*/*'

  Scenario: User Status List - Success Scenario
    Given path '/Common/UserStatusList'
    When method GET
    Then status 200
    Then print 'response --> ', response

    Then match $[0].isDefault == true
    Then match $[0].name == "be.user.enums.userstatus.active"
    Then match $[0].displayOrder == 0
    Then match $[0].id == 1
    Then match $[0].enumName == "Active"

    Then match $[1].isDefault == false
    Then match $[1].name == "be.user.enums.userstatus.passive"
    Then match $[1].displayOrder == 1
    Then match $[1].id == 0
    Then match $[1].enumName == "Passive"

    Then match $[2].isDefault == false
    Then match $[2].name == "be.user.enums.userstatus.blocked"
    Then match $[2].displayOrder == 2
    Then match $[2].id == 2
    Then match $[2].enumName == "Blocked"

    Then match $[3].isDefault == false
    Then match $[3].name == "be.user.enums.userstatus.notverified"
    Then match $[3].displayOrder == 3
    Then match $[3].id == 3
    Then match $[3].enumName == "NotVerified"

    #type control in array
    Then match response[*].isDefault contains ["#boolean"]
    Then match response[*].name contains ["#string"]
    Then match response[*].displayOrder contains ["#number"]
    Then match response[*].enumName contains [#string]
    Then match response[*].id contains [#number]