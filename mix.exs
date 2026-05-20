defmodule Contify.MixProject do
  @moduledoc false
  use Mix.Project

  @version "0.2.0"
  @url "https://github.com/EnaiaInc/contify"
  @maintainers ["Enaia Inc"]

  def project do
    [
      name: "Contify",
      app: :contify,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),

      # Hex package
      package: package(),
      description: "Contify API client for Elixir",
      source_url: @url,
      homepage_url: @url,

      # Docs
      docs: docs(),

      # Quality tooling
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        plt_add_apps: [:mix, :ex_unit]
      ],

      # Treat warnings as errors
      elixirc_options: [warnings_as_errors: true]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # HTTP client (req brings jason in transitively for JSON decoding)
      {:req, "~> 0.5"},
      {:jason, "~> 1.4"},

      # Test plug support (only used in test env via Req.Test)
      {:plug, "~> 1.16", optional: true},

      # Quality tooling
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.35", only: :dev, runtime: false},
      {:quokka, "~> 2.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      name: "contify",
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/contify/changelog.html",
        "GitHub" => @url
      },
      files: ~w(lib mix.exs README.md CHANGELOG.md LICENSE .formatter.exs)
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @url,
      extras: [
        "README.md",
        "CHANGELOG.md"
      ],
      groups_for_extras: [
        Changelog: ~r/CHANGELOG\.md/
      ],
      groups_for_modules: [
        "Public API": [Contify],
        Models: ~r/ContifyAPI\.Model\..*/,
        Internal: ~r/ContifyAPI\.(Client|Api)\..*/
      ]
    ]
  end
end
