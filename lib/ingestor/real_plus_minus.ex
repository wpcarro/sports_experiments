defmodule Sandbox.Ingestor.RealPlusMinus do
  @moduledoc false

  alias Sandbox.DepthChart

  @source_template "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/"
  @position_to_page_num %{
    point_guard:    1,
    shooting_guard: 2,
    small_forward:  5,
    power_forward:  6,
    center:         9,
  }


  def read do
  end

  @spec page_for_position(DepthChart.position) :: pos_integer
  def page_for_position(position) do
    page =
      Map.get(@position_to_page_num, position)

    Path.join(@source_template, inspect(page))
  end
end
