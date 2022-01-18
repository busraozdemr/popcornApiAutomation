Feature: Employee Refresh Token

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

  Scenario: Employee Refresh Token - Success Scenario
    Given path '/Employee/Login'
    * def employeeLoginInfo =
      """
          {
            "email": "busraozdmr.80@gmail.com",
            "password": "S6UNDKJB"
          }
      """
    And request employeeLoginInfo
    When method POST
    Then status 200
    Then print 'refresh login response -->',response

    * def userId = response.user.userId
    * def refreshToken = response.refreshToken

    Given path '/Employee/RefreshToken'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def employeeRefreshTokenInfo =
      """
          {
            "userId": "#(userId)",
            "refreshToken": "#(refreshToken)"
          }
      """
    And request employeeRefreshTokenInfo
    When method POST
    Then status 200
    Then print 'refresh token response -->',response
