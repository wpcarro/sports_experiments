defmodule String.ExtraTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest String.Extra


  describe "escape_digits/1" do
    test "works on inputs containing exclusively digits" do
      assert String.Extra.escape_digits("1234") == ~S/\1\2\3\4/
    end

    test "works on inputs containing more than digits" do
      assert String.Extra.escape_digits("My phone number is 1234")
        == ~S/My phone number is \1\2\3\4/
    end
  end


  describe "unescape_digits/1" do
    test "works on inputs containing exclusively digits" do
      assert String.Extra.unescape_digits(~S/\1\2\3\4/) == "1234"
    end

    test "works on inputs containing more than digits" do
      assert String.Extra.unescape_digits(~S/My phone number is \1\2\3\4/)
        == "My phone number is 1234"
    end
  end


  describe "string formatters" do
    test "classcase_to_titlecase/1" do
      assert String.Extra.classcase_to_titlecase("ModuleName") == "Module Name"
    end

    test "titlecase_to_snakecase/1" do
      assert String.Extra.titlecase_to_snakecase("Module Name") == "module_name"
    end
  end

  describe "kebabcase_to_titlecase/1" do
    test "works" do
      assert String.Extra.kebabcase_to_titlecase("dwight-howard") ==
        "Dwight Howard"

      assert String.Extra.kebabcase_to_titlecase("dwight-leonard-howard") ==
        "Dwight Leonard Howard"
    end
  end

  describe "shorthand_name/1" do
    test "works" do
      assert String.Extra.shorthand_name("Dwight Howard") ==
        "D. Howard"

      assert String.Extra.shorthand_name("Dwight Leonard Howard") ==
        "D. Leonard Howard"
    end
  end

end
