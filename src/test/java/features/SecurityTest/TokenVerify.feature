Feature:

  Background: Setup tests
    Given url "https://qa.insurance-api.tekschool-students.com"

  Scenario: Send valid request to /api/token/verify
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response.message == "Token is valid"

  #Story 5  #Endpoint: /api/token/verify
  #Send valid username invalid token
  #Response status 400
    #And response contain message "Token invalid or expired"

  Scenario: Send valid username invalid token to /api/token/verify
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = "Wrong Token"
    When method get
    And status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"

  #Story 4)
  #Endpoint: /api/token/verify
  #Send invalid user and valid token.
  #Response status 400
  # And response contain message "Wrong username send along with Token"

  Scenario: Send invalid username valid token to /api/token/verify
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/token/verify"
    And param username = "wrongusername"
    And param token = response.token
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

    Scenario: Create account with existing email /api/account/add-primary-account validate response


