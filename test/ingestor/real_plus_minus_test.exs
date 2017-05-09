defmodule Sandbox.Ingestor.RealPlusMinusTest do
  use ExUnit.Case

  alias Sandbox.Ingestor.RealPlusMinus

  describe "page_for_position/1" do
    test "works for point guards" do
      assert RealPlusMinus.page_for_position(:point_guard) ==
        "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/1"
    end

    test "works for shooting guards" do
      assert RealPlusMinus.page_for_position(:shooting_guard) ==
        "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/2"
    end

    test "works for small forwards" do
      assert RealPlusMinus.page_for_position(:small_forward) ==
        "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/5"
    end

    test "works for power forwards" do
      assert RealPlusMinus.page_for_position(:power_forward) ==
        "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/6"
    end

    test "works for center" do
      assert RealPlusMinus.page_for_position(:center) ==
        "https://www.espn.com/nba/statistics/rpm/_/sort/RPM/position/9"
    end
  end
end
