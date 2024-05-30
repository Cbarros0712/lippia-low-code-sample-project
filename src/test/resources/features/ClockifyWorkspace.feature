@Clockify

Feature: Low Code Clockify

  @AddWorkspace
  Scenario Outline: Add Workspace
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And header Content-Type = application/json
    And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
    And set value <nameWorkspace> of key name in body /jsons/bodies/AddWs.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameWorkspace  |
      | Workspace test |



  @AddWorkspace
  Scenario Outline: Add Workspace variable
    Given base url $(env.base_url)
    And endpoint /v1/workspaces
    And header Content-Type = application/json
    And header x-api-key = $(env.x-api-key)
    And set value <nameWorkspace> of key name in body /jsons/bodies/AddWs.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameWorkspace  |
      | Workspace test |

  @GetWorkspace
  Scenario: Get all my Workspaces
    Given base url $(env.base_url)
    And endpoint /v1/workspaces
    And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
    When execute method GET
    Then the status code should be 200
    And response should be [7].name = Workspace test
    * define espacioDeTrabajo = response[7].id


  @GetClientWorkspace1
  Scenario: Get all client from a Workspaces
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
    And execute method GET
    And the status code should be 200
    And response should be [7].name = Workspace test
    * define espacioDeTrabajo = response[7].id
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{espacioDeTrabajo}}/clients/
    And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
    When execute method GET
    Then the status code should be 200


  @GetClientWorkspace2
  Scenario: Get all client from a Workspaces with CALL
    Given call ClockifyWorkspace.feature@GetWorkspace
    And base url $(env.base_url)
    And endpoint /v1/workspaces/{{espacioDeTrabajo}}/clients/
    And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
    When execute method GET
    Then the status code should be 200
    * define idCliente = response[0].id

  @AddClientWorkspace
  Scenario: Add client from a Workspaces
    Given call ClockifyWorkspace.feature@GetWorkspace
    And base url $(env.base_url)
    And endpoint /v1/workspaces/{{espacioDeTrabajo}}/clients/
    And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
    And header Content-Type = application/json
    And set value NuevoClienteForAPI of key name in body /jsons/bodies/AddClient.json
    When execute method POST
    Then the status code should be 201

  @DeleteClientWorkspace
  Scenario: Delete client from a Workspaces
    Given call ClockifyWorkspace.feature@GetClientWorkspace2
    And base url $(env.base_url)
    And endpoint /v1/workspaces/{{espacioDeTrabajo}}/clients/{{idCliente}}
    And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
    And header Content-Type = application/json
    And set value NuevoClienteForAPI of key name in body /jsons/bodies/AddClient.json
    When execute method DELETE
    Then the status code should be 200