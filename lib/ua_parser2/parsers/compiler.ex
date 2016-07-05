defmodule UAParser2.Parsers.Compiler do
  @moduledoc """
  Parsers compiler.

  ## Usage

  iex> compile(%{
  ...>   "user_agent_parsers" => [%{"regex" => "UA"}],
  ...>   "engine_parsers" => [%{"regex" => "Engine"}],
  ...>   "os_parsers" => [%{"regex" => "OS"}],
  ...>   "device_parsers" => [%{"regex" => "Device"}],
  ...> })
  %{ ua: [%{regex: ~r/UA/}], engine: [%{regex: ~r/Engine/}], os: [%{regex: ~r/OS/}], device: [%{regex: ~r/Device/}] }

  iex> compile_collection([%{"regex" => "Firefox"}, %{"regex" => "Chrome"}])
  [%{ regex: ~r/Firefox/ }, %{ regex: ~r/Chrome/ }]

  iex> compile_one(%{"regex" => "Firefox"})
  %{ regex: ~r/Firefox/ }

  iex> compile_one(%{"regex" => "Firefox", "regex_flag" => "i"})
  %{ regex: ~r/Firefox/i }

  iex> compile_one(%{"regex" => "TestUnicode\\u0027"})
  %{ regex: ~r/TestUnicode\x{0027}/ }

  iex> compile_one(%{"regex" => "Chrome", "group" => [%{"regex" => "Chrome Mobile"}]})
  %{ regex: ~r/Chrome/, group: [%{regex: ~r/Chrome Mobile/}] }
  """

  @doc """
  Compiles parsers
  """
  @spec compile(Map) :: Map
  def compile(%{"user_agent_parsers" => ua_collection, 
                "engine_parsers"     => engine_collection,
                "os_parsers"         => os_collection,
                "device_parsers"     => device_collection}) do
    %{
      ua:     compile_collection(ua_collection),
      engine: compile_collection(engine_collection),
      os:     compile_collection(os_collection),
      device: compile_collection(device_collection)
    }
  end

  @doc """
  Compiles the collection of rules
  """
  @spec compile_collection(List) :: List
  def compile_collection(collection) when is_list(collection) do
    Enum.map(collection, &(compile_one(&1)))
  end

  @doc """
  Compiles the group of rules
  """
  @spec compile_one(Map) :: Map
  def compile_one(source = %{ "regex" => regex_str, "group" => group_regexes }) do
    regex_flag = Map.get(source, "regex_flag", "")

    regex = 
      regex_str
        |> fix_pcre
        |> Regex.compile!(regex_flag)

    group = 
      group_regexes 
        |> Enum.map(&(compile_one(&1)))

    %{ regex: regex, group: group }
  end

  @doc """
  Compiles one rule
  """
  @spec compile_one(Map) :: Map
  def compile_one(source = %{ "regex" => regex_str }) do
    regex_flag = Map.get(source, "regex_flag", "")

    regex = 
      regex_str
        |> fix_pcre
        |> Regex.compile!(regex_flag)

    %{ regex: regex }
      |> append_props(source)
  end

  defp append_props(parser, source) do
    source
      |> Map.take(["family", "v1", "v2", "v3", "v4", "device", "brand", "model", "type"])
      |> Enum.reduce(parser, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
  end

  # \uXXXX => \x{XXXX}
  defp fix_pcre(regex), do: Regex.replace(~r/\\u(\d{4})/, regex, "\\x{\\1}")
end