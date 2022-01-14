Feature: Get UserId By Referral Code

  Background:
    * url userApiUrl
    * header accept = '*/*'


  Scenario: Get UserId By Referral Code -  Success Scenario
    * def referralCode = authInfo.response.user.referralCode
    * def userId = authInfo.response.user.userId

    Given path 'Customer/GetUserIdByReferralCode?ReferralCode=' + referralCode
    When method GET
    Then status 200
    Then print 'response --> ', response
    Then match $ == "#(userId)"

  ######################################################################################################################

  Scenario: Get UserId By Referral Code -  Wrong ReferralCode
    * def referralCode = "wrongwrong1234"

    Given path 'Customer/GetUserIdByReferralCode?ReferralCode=' + referralCode
    When method GET
    Then status 204
