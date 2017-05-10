defmodule Sandbox.Resolver do
  @moduledoc false

  @abbrev_to_teamname %{
    "UTAH" => "Utah Jazz",
    "LAC" => "Los Angeles Clippers",
    "CHA" => "Charlotte Hornets",
    "GS" => "Golden State Warriors",
    "TOR" => "Toronto Raptors",
    "IND" => "Indiana Pacers",
    "MEM" => "Memphis Grizzlies",
    "SA" => "San Antonio Spurs",
    "BOS" => "Boston Celtics",
    "MIN" => "Minnesota Timberwolves",
    "HOU" => "Houston Rockets",
    "MIA" => "Miami Heat",
    "BKN" => "Brooklyn Nets",
    "PHI" => "Philadelphia 76ers",
    "MIL" => "Milwaukee Bucks",
    "DET" => "Detroit Pistons",
    "OKC" => "Oklahoma City Thunder",
    "WSH" => "Washington Wizards",
    "PHX" => "Phoenix Suns",
    "DAL" => "Dallas Mavericks",
    "DEN" => "Denver Nuggets",
    "ATL" => "Atlanta Hawks",
    "ORL" => "Orlando Magic",
    "POR" => "Portland Trailblazers",
    "CLE" => "Cleveland Cavaliers",
    "SAC" => "Sacramento Kings",
    "NY" => "New York Knicks",
  }


  @doc """
  Expands a city abbreviation into its full string representation.

  """
  @spec expand_city_abbrev(String.t) :: String.t
  def expand_city_abbrev(abbrev) do
    Map.get(@abbrev_to_teamname, abbrev)
  end

end
