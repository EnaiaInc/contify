# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Api.ContentTypes do
  @moduledoc """
  API calls for all endpoints tagged `ContentTypes`.
  """

  alias ContifyAPI.Connection
  import ContifyAPI.RequestBuilder

  @doc """
  Content-types list
  Returns a list of content-types for the authenticated user

  ### Parameters

  - `connection` (ContifyAPI.Connection): Connection to server
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, ContifyAPI.Model.IndustriesGet200Response.t}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec content_types_get(Tesla.Env.client(), keyword()) ::
          {:ok, ContifyAPI.Model.IndustriesGet200Response.t()}
          | {:ok, ContifyAPI.Model.Error.t()}
          | {:ok, String.t()}
          | {:error, Tesla.Env.t()}
  def content_types_get(connection, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/content-types")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, %ContifyAPI.Model.IndustriesGet200Response{}},
      {400, %ContifyAPI.Model.Error{}},
      {403, false},
      {404, %ContifyAPI.Model.Error{}},
      {405, %ContifyAPI.Model.Error{}},
      {500, %ContifyAPI.Model.Error{}},
      {503, false}
    ])
  end
end
