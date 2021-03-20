Feature: Crear un nuevo issue test script con ambiente de pruebas

  Background:
    * url urlApp
    * def token = authToken
    * configure headers = read('classpath:headers.js')



  Scenario: Crear un nuevo issue  - Create
    * def bodyIssue =
    """
    {
      "issue": {
        "project_id": 1,
        "subject": "Issue creado por jhurtado desde Postman",
        "priority_id": 4
      }
    }
    """
    Given path 'issues.json'
    And request bodyIssue
    When method post
    Then status 201