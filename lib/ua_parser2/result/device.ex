defmodule UAParser2.Result.Device do
  import UAParser2.Parser, only: [detect_prop: 5]

  defstruct [
    :family,
    :brand,
    :model,
    :type
  ]

  def new(m) do
    %UAParser2.Result.Device{
      family: Enum.at(m, 1),
      model:  Enum.at(m, 1),
    }
  end

  def assemble(nil), do: nil
  def assemble([m, parser]) do
    new(m)
    |> detect_prop(:family, :device, parser, m)
    |> detect_prop(:brand,  :brand,  parser, m)
    |> detect_prop(:model,  :model,  parser, m)
    |> detect_prop(:type,   :type,   parser, m)
  end
end