defmodule UAParser2 do
  @moduledoc """
  UAParser2 Application
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    options  = [ strategy: :one_for_one, name: UAParser2.Supervisor ]
    children = [
      supervisor(UAParser2.Parsers.Supervisor, []),
      UAParser2.Pool.child_spec
    ]

    Supervisor.start_link(children, options)
  end

  @doc """
  Parses a user agent string
  """
  @spec parse(String.t) :: map
  defdelegate parse(ua), to: UAParser2.Pool
end
