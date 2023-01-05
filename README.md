# [Contify API](https://developer.contify.com/api-documentation#introduction) client in Elixir



## Updating generated code

```sh
  java -jar bin/openapi-generator-cli-6.2.0.jar generate -i https://developer.contify.com/swagger/spec/Contify.json -g elixir -o /tmp/elixir_api_client
  cp -r /tmp/elixir_api_client/lib/contify_api/* lib/contify/
```

You may also update the files under `config`, etc.

## Building

To install the required dependencies and to build the elixir project, run:

```console
mix local.hex --force
mix do deps.get, compile
```

## Installation

If [available in Hex][], the package can be installed by adding `contify` to
your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:contify_api, "~> 3"}]
end
```

Documentation can be generated with [ExDoc][] and published on [HexDocs][]. Once published, the docs can be found at
[https://hexdocs.pm/contify_api][docs].

## Configuration

The API key can be added to the config as follows in the config.exs or runtime.exs:

config :contify, app_secret: <YOUR_API_KEY>
config :contify, app_id: <YOUR_APP_ID>

You can override the URL of your server (e.g. if you have a separate development and production server in your
configuration files).

```elixir
config :contify, base_url: "https://api.contify.com/v3"
```

Multiple clients for the same API with different URLs can be created passing different `base_url`s when calling
`ContifyAPI.Connection.new/1`:

```elixir
client = ContifyAPI.Connection.new(base_url: "https://api.contify.com/v3")
```

[exdoc]: https://github.com/elixir-lang/ex_doc
[hexdocs]: https://hexdocs.pm
[available in hex]: https://hex.pm/docs/publish
[docs]: https://hexdocs.pm/contify_api

## Usage
Contify.search_company(name: "some company")
Contify.request_company(name: "some company", url: "some domain")
Contify.subscribe_to_webhook(
  %{
        name: "some name",
        url: "some endpoint",
        headerName: "",
        headerValue: "",
        companyId: 678,
        industryId: "",
        contentTypeId: "",
        locationId: "",
        sourceId: "",
        channelId: "",
        topicId: "",
        customTopicId: "",
        languageId: "",
        keyword: "",
        advancedQuery: ""
      }
)