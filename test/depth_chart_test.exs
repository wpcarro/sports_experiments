defmodule Sandbox.DepthChartTest do
  use ExUnit.Case

  alias Sandbox.DepthChart

  test "expand_name" do
    player =
      {"td", [], [{"a", [{"href", "http://www.espn.com/nba/player/_/id/4257/derrick-favors"}], ["D. Favors\n"]}]}

    assert DepthChart.player_name(player) ==
      "Derrick Favors"
  end

end
