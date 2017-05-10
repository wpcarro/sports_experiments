defmodule Sandbox.Ingestor.RealPlusMinus do
  @moduledoc false

  alias Sandbox.DepthChart
  alias __MODULE__

  @local_path "rpm_"
  @remote_path "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/"

  @position_to_page_num %{
    point_guard:    1,
    shooting_guard: 2,
    small_forward:  5,
    power_forward:  6,
    center:         9,
  }

  defstruct [
    :ranking,
    :player_name,
    :team,
    :games_played,
    :minutes_per_game,
    :offensive_rpm,
    :defensive_rpm,
    :rpm,
    :wins,
  ]


  def rpm_for_position(position) do
    page_for_position(position)
    |> File.read!()
    |> Floki.parse()
    |> Floki.find(".mod-content table tr")
    |> Stream.drop(1) # drop the headers
    |> Stream.map(&decode_row/1) # drop the headers
    |> Enum.into([])
  end


  @doc """
  Decodes an HTML row into a `RealPlusMinus.t` struct.

  """
  def decode_row({"tr", _attrs, children}) do
    [rk, name, team, gp, mpg, orpm, drpm, rpm, wins] =
      children

    %RealPlusMinus{
      ranking: rk |> Floki.text() |> String.to_integer(),
      player_name: name |> Floki.text() |> String.trim(),
      team: team |> Floki.text() |> String.trim(),
      games_played: gp |> Floki.text() |> String.to_integer(),
      minutes_per_game: mpg |> Floki.text() |> String.to_float(),
      offensive_rpm: orpm |> Floki.text() |> String.to_float(),
      defensive_rpm: drpm |> Floki.text() |> String.to_float(),
      rpm: rpm |> Floki.text() |> String.to_float(),
      wins: wins |> Floki.text() |> String.to_float(),
    }
  end


  @doc """
  Returns the URI for RPM data for a specific position.

  ## Positions

    - `:point_guard`
    - `:shooting_guard`
    - `:small_forward`
    - `:power_forward`
    - `:center`

  ## Options

    - `:remote`: If set to `true`, the page returned will be the URI for the
    remote source. Defaults to `false`.

  """
  @spec page_for_position(DepthChart.position, opts) :: pos_integer when
  opts: [{:remote, boolean}]
  def page_for_position(position, opts \\ []) do
    remote? =
      opts[:remote] || false

    base =
      case remote? do
        true  -> @remote_path
        false -> @local_path
      end

    page_num =
      Map.get(@position_to_page_num, position)

    base <> inspect(page_num)
  end
end
