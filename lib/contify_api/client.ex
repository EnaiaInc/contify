defmodule ContifyAPI.Client do
  @moduledoc """
  Builds a configured `Req` client for the Contify API.

  Configuration is read from the application environment:

      config :contify,
        app_id: "your-app-id",
        app_secret: "your-app-secret",
        base_url: "https://api.contify.com/v3",
        timeout: 30_000

  `base_url` and `timeout` are optional and default to the values above.

  For tests, pass a `:plug` option to route requests through `Req.Test`:

      config :contify, req_options: [plug: {Req.Test, ContifyAPI.Client}]
  """

  @default_base_url "https://api.contify.com/v3"
  @default_timeout 30_000

  @doc """
  Returns a configured `Req.Request` ready to be used with `Req.request/2`,
  `Req.get/2`, `Req.post/2`, etc.
  """
  @spec new() :: Req.Request.t()
  def new do
    Req.new(
      base_url: base_url(),
      headers: [
        {"appid", app_id()},
        {"appsecret", app_secret()},
        {"user-agent", "contify-elixir/#{Application.spec(:contify, :vsn)}"}
      ],
      receive_timeout: timeout(),
      retry: false
    )
    |> Req.merge(req_options())
  end

  defp app_id, do: Application.fetch_env!(:contify, :app_id)
  defp app_secret, do: Application.fetch_env!(:contify, :app_secret)
  defp base_url, do: Application.get_env(:contify, :base_url, @default_base_url)
  defp timeout, do: Application.get_env(:contify, :timeout, @default_timeout)
  defp req_options, do: Application.get_env(:contify, :req_options, [])
end
