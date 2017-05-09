defmodule Config.Extra do
  @moduledoc false

  @default_separator "="

  @spec from_file(Path.t, key, opts) :: binary when
  key: binary | atom,
  opts: [{:separator, binary}]
  def from_file(path, key, opts \\ []) do
    separator =
      opts[:separator] || @default_separator

    File.read!(path)
    |> String.split("\n")
    |> Enum.reject(&match?("", &1))
    |> Enum.map(&decode(&1, separator))
    |> Map.new()
    |> Map.get(key)
  end

  @spec decode(binary, binary) :: {binary, binary}
  defp decode(line, separator) do
    [key, value] =
      String.split(line, separator)

    {String.trim(key), String.trim(value)}
  end
end
