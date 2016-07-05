defmodule UAParser2.Parsers.Cache do
  use GenServer

  alias UAParser2.Parsers.Compiler

  def start_link(filename) do
    GenServer.start_link(__MODULE__, filename, name: __MODULE__)
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def init(filename) do
    state = %{ 
      filename: filename, 
      parsers: load_parsers(filename) 
    }
    {:ok, state}
  end

  def handle_call(:get, _, state) do
    {:reply, state[:parsers], state}
  end

  defp load_parsers(filename) do
    case File.regular?(filename) do
      false -> {:error, "File #{filename} does not exists!"}
      true  ->
        filename
          |> YamlElixir.read_from_file
          |> Compiler.compile
    end
  end
end