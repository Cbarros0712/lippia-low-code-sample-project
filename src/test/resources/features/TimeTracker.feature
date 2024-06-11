

@GetWorkspace
Scenario: Get all my Workspaces
Given base url $(env.base_url)
And endpoint /v1/workspaces
And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
When execute method GET
Then the status code should be 200
And response should be [7].name = Workspace test
* define espacioDeTrabajo = response[7].id

@AddTimeEntry
Scenario : Add Time
Given base url $(env.base_url)
And endpoint /v1/workspaces/{espacioDeTrabajo}/time-entries
And header Content-Type = application/json
And header x-api-key = $(env.x-api-key)
And body jsons/bodies/AddTime.json
When execute method POST
Then the status code should be 201
* define id = response[4].id

@GetAllTime
Scenario: Get all client from a Workspaces
Given base url https://api.clockify.me/api
And endpoint /v1/workspaces/{espacioDeTrabajo}/time-entries/status/in-progress
And header Content-Type = application/json
And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
And execute method GET
And the status code should be 200


@PutTime
Scenario: Update id Time
Given base url https://api.clockify.me/api
And endpoint /v1/workspaces/{espacioDeTrabajo}/time-entries/{id}
And header Content-Type = application/json
And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
And body jsons/bodies/PutTime.json
And execute method PUT
Then the status code should be 200



@DeleteTime
Scenario: Delete id Time
Given base url https://api.clockify.me/api
And endpoint /v1/workspaces/{espacioDeTrabajo}/time-entries/{id}
And header Content-Type = application/json
And header x-api-key = NmU4MzczMmYtNmJkYS00MmNmLWEyMjYtYjgzMDNlOGFhMTkz
And execute method DELETE
Then the status code should be 204






