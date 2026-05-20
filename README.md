# Contify

[![Hex.pm](https://img.shields.io/hexpm/v/contify.svg)](https://hex.pm/packages/contify)
[![Documentation](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/contify)

An Elixir client for the [Contify API](https://developer.contify.com/api-documentation),
built on [`Req`](https://hex.pm/packages/req).

## Installation

Add `contify` to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:contify, github: "EnaiaInc/contify"}
  ]
end
```

## Configuration

Provide the application credentials via the application environment:

```elixir
# config/runtime.exs
config :contify,
  app_id: System.fetch_env!("CONTIFY_APP_ID"),
  app_secret: System.fetch_env!("CONTIFY_APP_SECRET")
```

Optional settings (with defaults shown):

```elixir
config :contify,
  base_url: "https://api.contify.com/v3",
  timeout: 30_000
```

`CONTIFY_API_BASE_URI` overrides the base URL at runtime.

## Usage

```elixir
{:ok, %ContifyAPI.Model.SearchCompanyGet200Response{results: [%ContifyAPI.Model.Company{} | _]}} =
  Contify.search_company(name: "Microsoft")

{:ok, %ContifyAPI.Model.RequestCompanyGet200Response{}} =
  Contify.request_company("Patagonia", "patagonia.com")

{:ok, %ContifyAPI.Model.InsightsResponse{results: [%ContifyAPI.Model.Insight{} | _]}} =
  Contify.insights(company_id: 1)

{:ok, %ContifyAPI.Model.WebhooksResponse{id: id}} =
  Contify.subscribe_to_webhook(%{
    name: "my-webhook",
    url: "https://example.com/contify",
    sourceId: "56"
  })

{:ok, _} = Contify.get_webhook(id)
{:ok, _} = Contify.update_webhook(id, %{name: "renamed"})
{:ok, _} = Contify.delete_webhook(id)
```

### Result tuple shapes

- `{:ok, %ContifyAPI.Model.* {} | %ContifyAPI.Model.Error{}}` — 2xx success
  or a structured API error returned in the response body.
- `{:error, %Req.TransportError{} | %Req.HTTPError{} | %Req.Response{}}` — transport
  failures or non-success responses without a recognizable error body.

## Testing

`Req.Test` is the supported way to intercept requests in tests:

```elixir
# config/test.exs
config :contify, req_options: [plug: {Req.Test, ContifyAPI.Client}]
```

```elixir
test "search returns a company" do
  Req.Test.expect(ContifyAPI.Client, fn conn ->
    Req.Test.json(conn, %{count: 1, results: [%{id: 697, name: "Microsoft"}]})
  end)

  assert {:ok, %ContifyAPI.Model.SearchCompanyGet200Response{
            results: [%ContifyAPI.Model.Company{id: 697}]
          }} = Contify.search_company(name: "Microsoft")
end
```

## License

MIT. See [LICENSE](./LICENSE).
