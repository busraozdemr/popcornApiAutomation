Feature: Customer List

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

  Scenario: Customer List - Success Scenario
    Given path '/Customer/List?CustomerStatus=2&Status=2'
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'customer list response --> ', response

      #expected value control
    Then match $.page.totalCount == '#number'
    Then match $.page.pageSize == '#number'
    Then match $.page.pageNumber == '#number'
    Then match $.page.hasNext == '#boolean'
    Then match response.items[*].statusText contains ["#string"]
    Then match response.items[*].statusName contains ["#string"]
    Then match response.items[*].phoneCountryId contains ["#string"]
    Then match response.items[*].id contains ["#string"]
    Then match response.items[*].status contains ["#number"]

    #null control
    Then match $.items[*].statusText != 'null'
    Then match $.items[*].statusName != 'null'
    Then match $.items[*].phoneCountryId != 'null'
    Then match $.items[*].id != 'null'
    Then match $.items[*].status != 'null'

    ####################################################################################################################

  Scenario: Customer List - Without Authorization
    Given path '/Customer/List?CustomerStatus=2&Status=2'
    When method GET
    Then status 401
    Then print 'customer list without authorization response --> ', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401
