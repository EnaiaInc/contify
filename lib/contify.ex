defmodule Contify do
  @moduledoc """
  Documentation for `Contify`.
  """

  alias ContifyAPI.Api.Company
  alias ContifyAPI.Api.Webhooks

  @type query :: map
  @type name :: binary
  @type url :: binary
  @type request_company_response ::
          {:ok, ContifyAPI.Model.Error.t()}
          | {:ok, ContifyAPI.Model.RequestCompanyGet200Response.t()}
          | {:ok, String.t()}
          | {:error, Tesla.Env.t()}
  @type search_company_response ::
          {:ok, ContifyAPI.Model.Error.t()}
          | {:ok, ContifyAPI.Model.RequestCompanyGet200Response.t()}
          | {:ok, String.t()}
          | {:error, Tesla.Env.t()}
  @type webhook :: map
  @type webhook_response ::
          {:ok, ContifyAPI.Model.Error.t()}
          | {:ok, ContifyAPI.Model.WebhooksResponse.t()}
          | {:ok, String.t()}
          | {:error, Tesla.Env.t()}

  @doc """
  Creates a webhook.

  ## Examples

      iex> Contify.subscribe_to_webhook(%{name: "some name",url: "some endpoint",headerName: "",headerValue: "",companyId: 678,industryId: "",contentTypeId: "",locationId: "",sourceId: "",channelId: "",topicId: "",customTopicId: "",languageId: "",keyword: "",advancedQuery: ""},    "secret", "key")
      {:ok, %ContifyAPI.Model.WebhookGetRequest{}}

  """

  @spec subscribe_to_webhook(webhook) :: webhook_response
  defdelegate subscribe_to_webhook(webhook), to: Webhooks

  @doc """
  Search for a Company.

  ## Examples

      iex> Contify.search_company([name: "some name", url: "some url", page: 1],"secret", "key")
      {:ok, %ContifyAPI.Model.RequestCompanyGet200Response{count: 30,   next: "?page=2",previous: nil,results: [
        %ContifyAPI.Model.Company{}]}

  """

  @spec search_company(query) :: search_company_response()
  defdelegate search_company(query), to: Company

  @doc """
  Request for a Company.

  ## Examples

      iex> Contify.request_company("some name", "some url","secret", "key")
      {:ok, %ContifyAPI.Model.RequestCompanyGet200Response{}

  """
  @spec request_company(name, url) :: request_company_response()
  defdelegate request_company(name, url), to: Company
end
