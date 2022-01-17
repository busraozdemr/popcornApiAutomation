Feature: Employee Find

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'


  Scenario: Employee Find - Success Scenario
    * def employeeCreateFeature = call read('employee_create.feature@employeeInfo')
    * def id = employeeCreateFeature.response.id

    Given path 'Employee/Find?Id=' + id
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee find response --> ', response
    Then match $.id == employeeCreateFeature.response.id
    Then match $.email == employeeCreateFeature.response.email
    Then match $.phoneNumber == employeeCreateFeature.response.phoneNumber
    Then match $.firstName == employeeCreateFeature.response.firstName
    Then match $.title == employeeCreateFeature.response.title
    Then match $.fullName == employeeCreateFeature.response.fullName
    Then match $.lastName == employeeCreateFeature.response.lastName
    Then match $.roles[0].name == employeeCreateFeature.response.roles[0].name
    Then match $.roles[0].id == employeeCreateFeature.response.roles[0].id
    Then match $.userId == employeeCreateFeature.response.userId
    Then match $.phoneCountry.name == employeeCreateFeature.response.phoneCountry.name
    Then match $.phoneCountry.id == employeeCreateFeature.response.phoneCountry.id
    Then match $.roleIds[0] == employeeCreateFeature.response.roleIds[0]

      #expected value control
    Then match $.lastName == '#string'
    Then match $.roles[0].name == '#string'
    Then match $.roles[0].id == '#string'
    Then match $.fullName == '#string'
    Then match $.title == '#string'
    Then match $.fullName == '#string'
    Then match $.userId == '#string'
    Then match $.phoneCountry.name == '#string'
    Then match $.phoneCountry.id == '#string'
    Then match $.firstName == '#string'
    Then match $.phoneNumber == '#string'
    Then match $.statusText == '#string'
    Then match $.email == '#string'
    Then match $.status == '#number'
    Then match $.id == '#string'

      ##################################################################################################################

  Scenario: Employee Find - Without Authorization
    * def employeeCreateFeature = call read('employee_create.feature@employeeInfo')
    * def id = employeeCreateFeature.response.id

    Given path 'Employee/Find?Id=' + id
    When method GET
    Then status 401
    Then print 'employee find without authorization response --> ', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

    ####################################################################################################################

  Scenario: Employee Find - Wrong Id
    * def id = "83dbde87-8010-4ddc-a017-11112558d215"

    Given path 'Employee/Find?Id=' + id
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 204