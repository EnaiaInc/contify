# [Contify API](https://developer.contify.com/api-documentation#introduction) client in Elixir

## Configuration

The API key can be added to the config as follows in the config.exs or runtime.exs:

```elixir
config :contify, app_secret: <YOUR_API_KEY>
config :contify, app_id: <YOUR_APP_ID>
```

Optionally, the timeout can be overriden:

```elixir
config :contify, timeout: 60_000
```

## Usage

```elixir
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
```

## Building

To install the required dependencies and to build the elixir project, run:

```console
mix local.hex --force
mix do deps.get, compile
```

## Updating generated code

```sh
  java -jar bin/openapi-generator-cli-6.2.0.jar generate -i https://developer.contify.com/swagger/spec/Contify.json -g elixir -o /tmp/elixir_api_client
  cp -r /tmp/elixir_api_client/lib/contify_api/* lib/contify/
```

You may also update the files under `config`, etc.
