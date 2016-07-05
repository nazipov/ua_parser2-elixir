defmodule UAParser2.Parser do
  alias UAParser2.Result.{UA,OS,Engine,Device}
  
  def parse(parsers, ua) do
    %UAParser2.Result{
      string: ua,
      ua:     parse_ua(parsers, ua),
      os:     parse_os(parsers, ua),
      engine: parse_engine(parsers, ua),
      device: parse_device(parsers, ua)
    }
  end

  defp parse_ua(%{ua: parsers}, ua) do
    find_parser(parsers, ua)
    |> UA.assemble
  end

  defp parse_os(%{os: parsers}, ua) do
    find_parser(parsers, ua) 
    |> OS.assemble
  end

  defp parse_engine(%{engine: parsers}, ua) do
    find_parser(parsers, ua) 
    |> Engine.assemble
  end

  defp parse_device(%{device: parsers}, ua) do
    find_parser(parsers, ua) 
    |> Device.assemble
  end

  def detect_prop(struct, struct_prop, parser_prop, parser, m) do
    case Map.fetch(parser, parser_prop) do
      {:ok, value} -> 
        Map.put(struct, struct_prop, replace_matches(value, m))
      :error -> 
        struct
    end
  end

  defp replace_matches(str, m) do
    rf = fn(_, i, j) -> 
      {p, _} = 
        [i, j] 
        |> Enum.find(fn v -> String.strip(v) !== "" end) 
        |> Integer.parse; 
      Enum.at(m, p)
    end
    Regex.replace(~r/\${(\d+)}|\$(\d+)/, str, rf, global: true)
    |> String.strip
  end

  defp find_parser([], _), do: nil
  defp find_parser([parser = %{ regex: regex, group: group_regexes }|parsers], ua) do
    if Regex.match?(regex, ua) do
      m = find_parser(group_regexes, ua)
      if m do
        m
      else
        find_parser(parsers, ua)
      end
    else
      find_parser(parsers, ua)
    end
  end
  defp find_parser([parser = %{ regex: regex }|parsers], ua) do
    if m = Regex.run(regex, ua) do
      [m, parser]
    else
      find_parser(parsers, ua)
    end
  end
end