defmodule Sandbox.DepthChart do
  @moduledoc false

  @source "nba_depth_charts.html"

  @type position :: :point_guard | :shooting_guard | :small_forward | :power_forward | :center

  alias __MODULE__

  defstruct [
    :city,
    :point_guard,
    :shooting_guard,
    :small_forward,
    :power_forward,
    :center,
  ]

  def read do
    File.read!(@source)
    |> Floki.parse()
  end

  def fetch_all(key) when is_atom(key) do
    depth_charts()
    |> Enum.map(&Map.get(&1, key))
  end

  def depth_charts do
    odd =
      read()
      |> Floki.find(".oddrow")
      |> Enum.map(&decode_row/1)

    even =
      read()
      |> Floki.find(".evenrow")
      |> Enum.map(&decode_row/1)

    odd ++ even
  end

  def player_name(player) do
    player
    |> Floki.attribute("a", "href")
    |> List.first()
    |> Path.basename()
    |> String.Extra.kebabcase_to_titlecase()
  end

  def all_players(team) do
    team
    |> Map.take([:point_guard, :shooting_guard, :small_forward, :power_forward, :center])
    |> Map.values()
  end

  defp decode_row({"tr", _attrs, children}) do
    [city, pg, sg, sf, pf, c] =
      children

    %DepthChart{
      city: Floki.text(city),
      point_guard: player_name(pg),
      shooting_guard: player_name(sg),
      power_forward: player_name(pf),
      small_forward: player_name(sf),
      center: player_name(c),
    }
  end

end
