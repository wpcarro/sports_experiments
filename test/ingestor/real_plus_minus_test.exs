defmodule Sandbox.Ingestor.RealPlusMinusTest do
  use ExUnit.Case

  alias Sandbox.Ingestor.RealPlusMinus

  describe "page_for_position/1" do
    test "(local) works for point guards" do
      assert RealPlusMinus.page_for_position(:point_guard) ==
        "rpm_1"
    end

    test "(remote) works for shooting guards" do
      assert RealPlusMinus.page_for_position(:shooting_guard, remote: true) ==
        "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/2"
    end

    test "(local) works for small forwards" do
      assert RealPlusMinus.page_for_position(:small_forward) ==
        "rpm_5"
    end

    test "(remote) works for power forwards" do
      assert RealPlusMinus.page_for_position(:power_forward, remote: true) ==
        "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/6"
    end

    test "(local) works for center" do
      assert RealPlusMinus.page_for_position(:center) ==
        "rpm_9"
    end
  end

  describe "decode_row/1" do
    test "works" do
      pg =
        {"tr", [{"class", "oddrow"}],
         [{"td", [], ["1"]},
          {"td", [],
           [{"a", [{"href", "https://www.espn.com/nba/player/_/id/2779/chris-paul"}],
             ["Chris Paul"]}]}, {"td", [], ["LAC"]},
          {"td", [{"style", "text-align:right;"}], ["61"]},
          {"td", [{"style", "text-align:right;"}], ["31.5"]},
          {"td", [{"style", "text-align:right;"}], ["5.16"]},
          {"td", [{"style", "text-align:right;"}], ["2.77"]},
          {"td", [{"style", "text-align:right;"}, {"class", "sortcell"}], ["7.93"]},
          {"td", [{"style", "text-align:right;"}], ["13.50"]}]}

      assert RealPlusMinus.decode_row(pg) ==
        %RealPlusMinus{
          ranking: 1,
          player_name: "Chris Paul",
          team: "LAC",
          games_played: 61,
          minutes_per_game: 31.5,
          offensive_rpm: 5.16,
          defensive_rpm: 2.77,
          rpm: 7.93,
          wins: 13.50,
        }
    end
  end
end
