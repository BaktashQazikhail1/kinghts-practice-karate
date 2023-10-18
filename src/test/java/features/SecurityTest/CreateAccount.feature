Feature: Create Account

  #Story 9)
  #Endpoint: /api/accounts/add-primary-account
  #Send request
  #Validate response is 201
  #And response contain you request. email entity is correct

  Scenario: Create Account
  Given url "https://qa.insurance-api.tekschool-students.com"
  Given path "api/token"
  Given request {"username": "supervisor","password": "tek_supervisor"}
  When method post
  Then status 200
  And print response