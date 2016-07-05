defmodule UAParser2.Result.UA do
  import UAParser2.Parser, only: [detect_prop: 5]

  defstruct [
    :family,
    :major,
    :minor,
    :patch,
    :type
  ]

  def new(m) do
    %UAParser2.Result.UA{
      family: Enum.at(m, 1),
      major:  Enum.at(m, 2),
      minor:  Enum.at(m, 3),
      patch:  Enum.at(m, 4),
      type:   nil
    }
  end

  def assemble(nil), do: nil
  def assemble([m, parser]) do
    new(m)
    |> detect_prop(:family, :family, parser, m)
    |> detect_prop(:major,  :v1,     parser, m)
    |> detect_prop(:minor,  :v2,     parser, m)
    |> detect_prop(:patch,  :v3,     parser, m)
    |> detect_prop(:type,   :type,   parser, m)
  end
end