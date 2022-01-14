Feature: File Type List

  Background:
    * url userApiUrl
    * header accept = '*/*'

    Scenario: File Type List - Success Scenario
      Given path '/Common/FileTypeList'
      When method GET
      Then status 200
      Then print 'response --> ', response

      Then match $[0].isDefault == true
      Then match $[0].displayOrder == 0
      Then match $[0].id == 0
      Then match $[0].enumName == "Unknown"

      Then match $[1].isDefault == false
      Then match $[1].displayOrder == 0
      Then match $[1].id == 10
      Then match $[1].enumName == "Image"

      Then match $[2].isDefault == false
      Then match $[2].displayOrder == 0
      Then match $[2].id == 20
      Then match $[2].enumName == "Video"

      Then match $[3].isDefault == false
      Then match $[3].displayOrder == 0
      Then match $[3].id == 30
      Then match $[3].enumName == "Audio"

      #type control in array
      Then match response[*].isDefault contains ["#boolean"]
      Then match response[*].displayOrder contains ["#number"]
      Then match response[*].enumName contains [#string]
      Then match response[*].id contains [#number]