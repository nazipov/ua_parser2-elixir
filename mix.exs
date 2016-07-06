defmodule UAParser2.Mixfile do
  use Mix.Project

  def project do
    [app: :ua_parser2,
     version: "0.0.2",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [
      applications: [:logger, :yaml_elixir],
      mod: { UAParser2, [] }
    ]
  end

  defp deps do
    [{:yaml_elixir, "~> 1.0.0"},
     {:yamerl, github: "yakaz/yamerl"},
     {:poolboy, "~> 1.0"}]
  end

  defp description do
    """
      A port of ua-parser2 to Elixir. User agent parser library.
    """
  end

  defp package do
    [
      name:        :ua_parser2,
      maintainers: ["Almaz Nazipov"],
      licenses:    ["Apache 2.0"],
      links:       %{ "GitHub" => "https://github.com/nazipov/ua_parser2-elixir" }
    ]
  end
end
