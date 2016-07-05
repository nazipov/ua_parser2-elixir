defmodule UAParser2.Mixfile do
  use Mix.Project

  def project do
    [app: :ua_parser2,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
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
end
