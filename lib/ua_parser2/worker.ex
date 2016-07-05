defmodule UAParser2.Worker do
  use GenServer
  @behaviour :poolboy_worker

  alias UAParser2.{Parsers.Cache,Parser}

  def start_link(default \\ %{}) do
    GenServer.start_link(__MODULE__, %{ parsers: Cache.get })
  end

  def handle_call({ :parse, ua }, _, state) do
    { :reply, Parser.parse(state[:parsers], ua), state }
  end
end