defmodule Sandbox.RotoWire do
  @moduledoc false

  alias Sandbox.DepthChart

  @user "RotoWire"
  @max_count 100

  @nba_teams_re DepthChart.fetch_all(:city) |> Enum.join("|") |> Regex.compile!([:caseless])

  @nba_players_longhand DepthChart.depth_charts() |> Enum.flat_map(&DepthChart.all_players/1)
  @nba_players_shorthand @nba_players_longhand |> Enum.map(&String.Extra.shorthand_name/1)
  @nba_players_re (@nba_players_longhand ++ @nba_players_shorthand) |> Enum.join("|") |> Regex.compile!([:caseless])

  IO.inspect(@nba_players_re)

  def read do
    ExTwitter.search(@user, count: @max_count)
  end

  def tweets do
    read()
    |> Enum.map(&Map.get(&1, :text))
  end

  def cross_reference do
    tweets
    |> Enum.filter(fn x ->
      Regex.match?(@nba_teams_re, x) or Regex.match?(@nba_players_re, x)
    end)
  end
end
