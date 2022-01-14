Feature: Customer Login Authentication

Background:
* url 'https://testapi.popcornvan.cloud/user/'
* header Content-Type = 'application/json-patch+json'
* header accept = '*/*'

  Scenario: Customer Login - Authentication
    Given path '/Customer/Login'
    * def user =
      """
        {
          "email": "busraozdmr.801@gmail.com",
          "password": "123Asd123"
        }
      """
    And request user
    When method POST
    Then status 200