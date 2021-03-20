Feature: Crear proyectos en el api de redmine

  Background:
    * url urlApp
    * def token = authToken
    * configure headers = read('classpath:headers.js')

  Scenario: Crear un nuevo proyecto en redmine
    Given path 'projects.json'
    And request read('projectData.json')
    When method post
    Then status 201


  Scenario Outline:  Crear un nuevo proyecto desde examples
    * def numberRandom = function() {return (Math.floor(Math.random() * (900000) ) + 100000).toString()}
    * def numberRandom = 'redmineproject' + numberRandom()

    Given path 'projects.json'
    And request read('project_parameters.json')
    When method post
    Then status 201
    And match response.project.name == '<name>'
    And match response.project.description == '<description>'

    Examples:
      | name             | description              | inherit_members | is_public |
      | redmineProyecto1 | esta es una descripcion1 | false           | true      |
      | redmineProyecto2 | esta es una descripcion2 | true            | false     |


  Scenario Outline:  Crear un nuevo proyecto desde un archivo csv
    * def numberRandom = function() {return (Math.floor(Math.random() * (900000) ) + 100000).toString()}
    * def numberRandom = 'redmineproject' + numberRandom()

    Given path 'projects.json'
    And request read('project_parameters.json')
    When method post
    Then status 201
    And match response.project.name == '<name>'
    And match response.project.description == '<description>'

    Examples:
      | read('projects.csv') |