Feature: Api testing a los servicios de issues de redmine
  Yo ..

  Background:
    * url 'http://198.211.98.120:8081'

  Scenario: Obtener la lista de todos los issues
    Given path 'issues.json'
    When method get
    Then status 200


  Scenario: Obtener un issue por su id
    * def idIssue =  3488
    Given path 'issues', idIssue + '.json'
    When method get
    Then status 200
    And match response.issue.id == 3488
    And match response.issue.status.name == 'New'
    And match response.issue.priority.name == 'Immediate'
    And match response.issue.subject == 'Issue modificado por JHHA'
    And match response.issue.description == 'Esta es una descripcion paara prueba'
    And match response.issue.is_private == false
    And match response.issue.start_date == '2021-02-13'

  Scenario: UnHappyPath : Obtener un issue por su id
    * def idIssue =  9999
    Given path 'issues', idIssue + '.json'
    When method get
    Then status 404


  Scenario: Crear un nuevo issue
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
    And header X-Redmine-API-Key = 'ccb0c7377946014cdf7efe0346ed26a93cc7e1b7'
    And request bodyIssue
    When method post
    Then status 201


  Scenario: Crear un nuevo issue y eliminarlo
    * def bodyIssue =
    """
    {
      "issue": {
        "project_id": 1,
        "subject": "Issue creado por JH desde Karate DSL",
        "priority_id": 4
      }
    }
    """
    Given path 'issues.json'
    And header X-Redmine-API-Key = 'ccb0c7377946014cdf7efe0346ed26a93cc7e1b7'
    And request bodyIssue
    When method post
    Then status 201

    * def id = response.issue.id
    * print 'El issue id es: ', id

    Given path '/issues/'+id+'.json'
    And header X-Redmine-API-Key = 'ccb0c7377946014cdf7efe0346ed26a93cc7e1b7'
    When method delete
    Then status 204


  Scenario: Crear un nuevo issue  y actualizarlo
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
    And header X-Redmine-API-Key = 'ccb0c7377946014cdf7efe0346ed26a93cc7e1b7'
    And request bodyIssue
    When method post
    Then status 201

    * def id = response.issue.id
    * print 'El issue id es: ', id

    Given path 'issues', id + '.json'
    And header X-Redmine-API-Key = 'ccb0c7377946014cdf7efe0346ed26a93cc7e1b7'
    And request
    """
    {
      "issue": {
        "subject": "Issue modificado por jhurtado",
        "description": "Esta es una descripcion",
        "priority_id": 5,
        "notes": "The subject was changed"
      }
    }
    """
    When method put
    Then status 204
