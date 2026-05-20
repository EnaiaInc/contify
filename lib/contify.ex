defmodule Contify do
  @moduledoc """
  Contify API client for Elixir.

  See the [Contify API documentation](https://developer.contify.com/api-documentation)
  for details on the underlying endpoints.

  ## Configuration

  Set the API credentials in your application config:

      config :contify,
        app_id: "your-app-id",
        app_secret: "your-app-secret"

  Optional config:

      config :contify,
        base_url: "https://api.contify.com/v3",
        timeout: 30_000

  For tests, pass a Req.Test plug to intercept HTTP calls without touching the network:

      # config/test.exs
      config :contify, req_options: [plug: {Req.Test, ContifyAPI.Client}]
  """

  alias ContifyAPI.Api.Company
  alias ContifyAPI.Api.Insights
  alias ContifyAPI.Api.Webhooks
  alias ContifyAPI.Model

  @typedoc "Result of a Contify API call."
  @type result(success_t) ::
          {:ok, success_t | Model.Error.t()} | {:error, Exception.t() | Req.Response.t()}

  @doc """
  Get insights for the given filters. See `ContifyAPI.Api.Insights.insights/1`
  for the full option list.
  """
  @spec insights(keyword()) :: result(Model.InsightsResponse.t())
  defdelegate insights(params), to: Insights

  @doc """
  Search for a company by name and/or url. See `ContifyAPI.Api.Company.search_company/1`.
  """
  @spec search_company(keyword()) :: result(Model.SearchCompanyGet200Response.t())
  defdelegate search_company(query), to: Company

  @doc """
  Request a new company by name and url. See `ContifyAPI.Api.Company.request_company/2`.
  """
  @spec request_company(String.t(), String.t()) :: result(Model.RequestCompanyGet200Response.t())
  defdelegate request_company(name, url), to: Company

  @doc "Subscribe to a webhook. See `ContifyAPI.Api.Webhooks.subscribe_to_webhook/1`."
  @spec subscribe_to_webhook(map()) :: result(Model.WebhooksResponse.t())
  defdelegate subscribe_to_webhook(webhook), to: Webhooks

  @doc "List all webhooks. See `ContifyAPI.Api.Webhooks.list_webhooks/0`."
  @spec list_webhooks() :: result(Model.WebhookGet200Response.t())
  defdelegate list_webhooks(), to: Webhooks

  @doc "Get a webhook by id. See `ContifyAPI.Api.Webhooks.get_webhook/1`."
  @spec get_webhook(integer() | String.t()) :: result(Model.WebhooksResponse.t())
  defdelegate get_webhook(id), to: Webhooks

  @doc "Update a webhook. See `ContifyAPI.Api.Webhooks.update_webhook/2`."
  @spec update_webhook(integer() | String.t(), map()) :: result(Model.WebhooksResponse.t())
  defdelegate update_webhook(id, webhook), to: Webhooks

  @doc "Delete a webhook. See `ContifyAPI.Api.Webhooks.delete_webhook/1`."
  @spec delete_webhook(integer() | String.t()) :: result(nil)
  defdelegate delete_webhook(id), to: Webhooks
end
