defmodule ContifyAPI.Api.Company do
  @moduledoc """
  API calls for endpoints tagged `Company`.
  """

  alias ContifyAPI.Client
  alias ContifyAPI.Model.Company
  alias ContifyAPI.Model.RequestCompanyGet200Response
  alias ContifyAPI.Model.SearchCompanyGet200Response

  @doc """
  Search for a company.

  Use the search company endpoint to fetch a list of companies against a query
  string. The elements in the companies list contain an ID along with additional
  information like company name, url, HQ country, etc.

  ## Options

  - `:name` (String.t) — company name to search
  - `:url` (String.t) — company website URL to search
  - `:page` (integer) — paginate through the results

  ## Returns

  - `{:ok, SearchCompanyGet200Response.t}` on success
  - `{:ok, ContifyAPI.Model.Error.t}` on 4xx with an error body
  - `{:error, Exception.t | Req.Response.t}` on transport/other failures
  """
  @spec search_company(keyword()) ::
          {:ok, SearchCompanyGet200Response.t() | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def search_company(query) do
    Client.new()
    |> Req.get(url: "/search-company", params: query)
    |> ContifyAPI.Response.decode(SearchCompanyGet200Response)
  end

  @doc """
  Request a company that wasn't found via `search_company/1`.

  ## Returns

  - `{:ok, RequestCompanyGet200Response.t}` on success
  - `{:ok, ContifyAPI.Model.Error.t}` on 4xx with an error body
  - `{:error, Exception.t | Req.Response.t}` on transport/other failures
  """
  @spec request_company(String.t(), String.t()) ::
          {:ok, RequestCompanyGet200Response.t() | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def request_company(name, url) do
    Client.new()
    |> Req.get(url: "/request-company", params: [name: name, url: url])
    |> ContifyAPI.Response.decode(RequestCompanyGet200Response)
  end

  # Used by Response decoding to hydrate nested company structs.
  @doc false
  def to_struct(map), do: ContifyAPI.Response.to_struct(map, Company)
end
