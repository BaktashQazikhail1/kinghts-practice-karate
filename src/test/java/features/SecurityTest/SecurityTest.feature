Feature: Security Token API Calls

  Scenario: Send request to /api/token
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200

    #Activity, try Story 2)
  #Endpoint: /api/token
  #Test with wrong username
  # And status should be 404

  Scenario Outline: Send request to /api/token
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request
    """
    {
  "username": "<data_username>",
  "password": "<data_password>"
   }
    """
    When method post
    And print response
    Then status <expectedStatus>
    And assert response.httpStatus == "<httpStatus>"
    And assert response.errorMessage == "<errorMessage>"

    Examples:

    |data_username | data_password | expectedStatus | httpStatus | errorMessage |
    |WrongUsername | tek_supervisor| 404            | NOT_FOUND  |User WrongUsername not found|
    |supervisor    | ad;aakd3kja   | 400            | BAD_REQUEST|Password not matched|