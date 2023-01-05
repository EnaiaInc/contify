defmodule Contify.MixProject do
  use Mix.Project

  def project do
    [
      app: :contify,
      version: "0.1.0",
      elixir: "~> 1.12",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: "Contify API client",
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:poison, "~> 3.0"},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:ex_format, "~> 0.1.0"}
    ]
  end

  defp package do
    [
      name: "contify",
      files: ~w(.formatter.exs config lib mix.exs README* LICENSE*)
    ]
  end
end
