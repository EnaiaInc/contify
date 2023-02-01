defmodule Contify do
  @moduledoc """
  Documentation for `Contify`.
  """

  alias ContifyAPI.Api.Company
  alias ContifyAPI.Api.Insights
  alias ContifyAPI.Api.Webhooks

  @type query :: map
  @type name :: binary
  @type url :: binary
  @type insights_response ::
          {:ok, ContifyAPI.Model.Error.t()}
          | {:ok, ContifyAPI.Model.InsightsResponse.t()}
          | {:ok, String.t()}
          | {:error, Tesla.Env.t()}
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
          {:ok, ContifyAPI.Model.WebhooksResponse.t()}
          | {:ok, String.t()}
          | {:error, ContifyAPI.Model.Error.t()}
          | {:error, Tesla.Env.t()}

  @doc """
  Get insights for a given company.

  ## Examples

      iex> Contify.insights()
      {:ok, %ContifyAPI.Model.InsightsRequest{}}

  """
  @type params :: keyword
  @spec insights(params) :: insights_response
  defdelegate insights(params), to: Insights

  @doc """
  Creates a webhook.

  ## Examples

      iex> Contify.subscribe_to_webhook(%{name: "some name",url: "some endpoint",headerName: "",headerValue: "",companyId: 678,industryId: "",contentTypeId: "",locationId: "",sourceId: "",channelId: "",topicId: "",customTopicId: "",languageId: "",keyword: "",advancedQuery: ""})
      {:ok, %ContifyAPI.Model.WebhookGetRequest{}}

  """

  @spec subscribe_to_webhook(webhook) :: webhook_response
  defdelegate subscribe_to_webhook(webhook), to: Webhooks
  defdelegate list_webhooks(), to: Webhooks
  defdelegate get_webhook(id), to: Webhooks
  defdelegate update_webhook(id, webhook), to: Webhooks
  defdelegate delete_webhook(webhook), to: Webhooks

  @doc """
  Search for a Company.

  ## Examples

      iex> Contify.search_company([name: "some name", url: "some url", page: 1])
      {:ok, %ContifyAPI.Model.RequestCompanyGet200Response{count: 30,   next: "?page=2",previous: nil,results: [
        %ContifyAPI.Model.Company{}]}

  """

  defdelegate search_company(query), to: Company

  @doc """
  Request for a Company.

  ## Examples

      iex> Contify.request_company("some name", "some url")
      {:ok, %ContifyAPI.Model.RequestCompanyGet200Response{}

  """
  @spec request_company(name, url) :: request_company_response()
  defdelegate request_company(name, url), to: Company
end
