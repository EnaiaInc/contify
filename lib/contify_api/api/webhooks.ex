defmodule ContifyAPI.Api.Webhooks do
  @moduledoc """
  API calls for endpoints tagged `Webhooks`.
  """

  alias ContifyAPI.Client
  alias ContifyAPI.Model.WebhooksResponse

  @doc """
  Subscribe to a new webhook.
  """
  @spec subscribe_to_webhook(map()) ::
          {:ok, WebhooksResponse.t() | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def subscribe_to_webhook(webhook) do
    Client.new()
    |> Req.post(url: "/webhook/", json: drop_nil_values(webhook))
    |> ContifyAPI.Response.decode(WebhooksResponse)
  end

  @doc """
  List all active webhooks created by the authenticated user.
  """
  @spec list_webhooks() ::
          {:ok, [WebhooksResponse.t()] | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def list_webhooks do
    Client.new()
    |> Req.get(url: "/webhook/")
    |> ContifyAPI.Response.decode_list(WebhooksResponse)
  end

  @doc """
  Get details of a particular webhook by id.
  """
  @spec get_webhook(integer() | String.t()) ::
          {:ok, WebhooksResponse.t() | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def get_webhook(id) do
    Client.new()
    |> Req.get(url: "/webhook/#{id}/")
    |> ContifyAPI.Response.decode(WebhooksResponse)
  end

  @doc """
  Update a particular webhook.
  """
  @spec update_webhook(integer() | String.t(), map()) ::
          {:ok, WebhooksResponse.t() | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def update_webhook(id, webhook) do
    Client.new()
    |> Req.put(url: "/webhook/#{id}/", json: drop_nil_values(webhook))
    |> ContifyAPI.Response.decode(WebhooksResponse)
  end

  @doc """
  Delete a particular webhook.
  """
  @spec delete_webhook(integer() | String.t()) ::
          {:ok, nil | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def delete_webhook(id) do
    Client.new()
    |> Req.delete(url: "/webhook/#{id}/")
    |> ContifyAPI.Response.decode(nil)
  end

  defp drop_nil_values(%_struct{} = webhook),
    do: webhook |> Map.from_struct() |> Map.reject(&nil_value?/1)

  defp drop_nil_values(webhook) when is_map(webhook), do: Map.reject(webhook, &nil_value?/1)

  defp nil_value?({_key, value}), do: is_nil(value)
end
