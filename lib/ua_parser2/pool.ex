defmodule UAParser2.Pool do
  @pool_name __MODULE__

  def child_spec do
    opts = [
      name:          { :local, @pool_name },
      worker_module: UAParser2.Worker,
      size:          Application.get_env(:ua_parser2, :pool)[:size] || 5,
      max_overflow:  Application.get_env(:ua_parser2, :pool)[:max_overflow] || 10
    ]

    :poolboy.child_spec(__MODULE__, opts, [])
  end

  @doc """
  Sends a parse request to a pool worker.
  """
  @spec parse(String.t) :: map
  def parse(ua) do
    :poolboy.transaction(
      @pool_name,
      &GenServer.call(&1, { :parse, ua })
    )
  end
end