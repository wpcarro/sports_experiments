defmodule Sandbox.ResolverTest do
  use ExUnit.Case

  alias Sandbox.Resolver

  describe "expand_city_abbrev/1" do
    test "works" do
      Resolver.expand_city_abbrev("UTAH") == "Utah Jazz"
      Resolver.expand_city_abbrev("LAC") == "Los Angeles Clippers"
      Resolver.expand_city_abbrev("NY") == "New York Knicks"
      Resolver.expand_city_abbrev("POR") == "Portland Trailblazers"
    end
  end
end
