defmodule UAParser2.Parsers.Supervisor do
  use Supervisor

  def start_link(default \\ []) do
    Supervisor.start_link(__MODULE__, default)
  end

  def init(_default) do
    filename = Path.join(:code.priv_dir(:ua_parser2), "regexes.yaml")

    children = [
      worker(UAParser2.Parsers.Cache, [filename]),
    ]

    supervise(children, strategy: :one_for_all)
  end
end