Feature: Employee List

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'


  Scenario: Employee List - Success Scenario With Email
    * def employeeCreateFeature = call read('employee_create.feature@employeeInfo')
    * def email = employeeCreateFeature.response.email

    Given path '/Employee/List?Email=' + email
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee list search with email response --> ', response
    Then match $.page.totalCount == 1
    Then match $.items[0].fullName == employeeCreateFeature.response.fullName
    Then match $.items[0].title == employeeCreateFeature.response.title
    Then match $.items[0].firstName == employeeCreateFeature.response.firstName
    Then match $.items[0].email == employeeCreateFeature.response.email

    #expected value control
    Then match $.page.pageNumber == '#number'
    Then match $.page.pageSize == '#number'
    Then match $.page.hasNext == '#boolean'
    Then match $.page.totalCount == '#number'
    Then match $.items[0].lastName == '#string'
    Then match $.items[0].fullName == '#string'
    Then match $.items[0].title == '#string'
    Then match $.items[0].firstName == '#string'
    Then match $.items[0].statusText == '#string'
    Then match $.items[0].statusName == '#string'
    Then match $.items[0].phoneCountryId == '#string'
    Then match $.items[0].id == '#string'
    Then match $.items[0].email == '#string'
    Then match $.items[0].status == '#number'

    ####################################################################################################################

  Scenario: Employee List - Without Authorization
    * def employeeCreateFeature = call read('employee_create.feature@employeeInfo')
    * def email = employeeCreateFeature.response.email

    Given path '/Employee/List?Email=' + email
    When method GET
    Then status 401
    Then print 'employee list search without authorization response --> ', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

    ####################################################################################################################

  Scenario: Employee List - Wrong Email
    * def email = "wrong"

    Given path '/Employee/List?Email=' + email
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee list search with wrong email response --> ', response
    Then match $.page.pageNumber == 0
    Then match $.page.pageSize == 0
    Then match $.page.hasNext == false
    Then match $.page.totalCount == 0

    ####################################################################################################################

  Scenario: Employee List - Success Scenario With Phone Number
    * def employeeCreateFeature = call read('employee_create.feature@employeeInfo')
    * def phoneNumber = employeeCreateFeature.response.phoneNumber
    * def email = employeeCreateFeature.response.email

    Given path '/Employee/List?PhoneNumber=' + phoneNumber
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee list search with phone number response --> ', response
    Then match $.page.totalCount == 1
    Then match $.items[0].fullName == employeeCreateFeature.response.fullName
    Then match $.items[0].title == employeeCreateFeature.response.title
    Then match $.items[0].firstName == employeeCreateFeature.response.firstName
    Then match $.items[0].email == employeeCreateFeature.response.email

    ####################################################################################################################

  Scenario: Employee List - Success Scenario With Wrong Phone Number
    * def phoneNumber = "wrong"

    Given path '/Employee/List?PhoneNumber=' + phoneNumber
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee list search with wrong phone number response --> ', response
    Then match $.page.pageNumber == 0
    Then match $.page.pageSize == 0
    Then match $.page.hasNext == false
    Then match $.page.totalCount == 0

    ####################################################################################################################

  Scenario: Employee List - Success Scenario With Full Name
    * def employeeCreateFeature = call read('employee_create.feature@employeeInfo')
    * def firstName = employeeCreateFeature.response.firstName
    * def lastName = employeeCreateFeature.response.firstName

    Given path '/Employee/List?FullName=' + firstName + '%20' + lastName
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee list search with full name response --> ', response
    Then match $.page.totalCount == 1
    Then match $.items[0].fullName == employeeCreateFeature.response.fullName
    Then match $.items[0].title == employeeCreateFeature.response.title
    Then match $.items[0].firstName == employeeCreateFeature.response.firstName
    Then match $.items[0].email == employeeCreateFeature.response.email

    ####################################################################################################################

  Scenario: Employee List - Success Scenario With Wrong Full Name
    * def firstName = "wrong"
    * def lastName = "wrong"

    Given path '/Employee/List?FullName=' + firstName + '%20' + lastName
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee list search with wrong full name response --> ', response
    Then match $.page.pageNumber == 0
    Then match $.page.pageSize == 0
    Then match $.page.hasNext == false
    Then match $.page.totalCount == 0
