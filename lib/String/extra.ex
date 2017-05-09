defmodule String.Extra do
  @moduledoc """
  Extensions to the built-in `String` module.

  """

  @single_digit_regex ~r/\d/
  @escaped_digit_regex ~r/\\(\d)/


  @doc """
  Naive titlecasing function. Works on strings with single spaces as
  separators and doesn't take into account edge cases like "a",
  "and", etc.

      iex> String.Extra.title_case("this is a test.")
      "This Is A Test."

  """
  @spec title_case(String.t) :: String.t
  def title_case(string) do
    string
    |> String.split
    |> Stream.map(&String.capitalize/1)
    |> Enum.join(" ")
  end


  @doc """
  Converts text that's formatted as ClassCase into text that is formatted as
  Title Case.

      iex> String.Extra.classcase_to_titlecase("ModuleName")
      "Module Name"

  """
  @classcase_split_regex ~r/(?<![A-Z])(?=[A-Z])/
  @spec classcase_to_titlecase(String.t) :: String.t
  def classcase_to_titlecase(string) do
    string
    |> String.split(@classcase_split_regex)
    |> Enum.join(" ")
  end


  @doc """
  Converts text that's formatted as ClassCase into text that is formatted as
  Title Case.

      iex> String.Extra.classcase_to_titlecase("ModuleName")
      "Module Name"

  """
  @spec titlecase_to_snakecase(String.t) :: String.t
  def titlecase_to_snakecase(string) do
    string
    |> String.downcase()
    |> String.replace(~r/\s+/, "_")
  end


  @doc """
  Escapes digits within a provided string.

  """
  @spec escape_digits(String.t) :: String.t
  def escape_digits(input) when is_binary(input) do
    Regex.replace(@single_digit_regex, input, fn(digit) ->
      "\\" <> digit
    end)
  end


  @doc """
  Unescapes digits within a provided string.

  """
  @spec unescape_digits(String.t) :: String.t
  def unescape_digits(input) when is_binary(input) do
    Regex.replace(@escaped_digit_regex, input, fn(_, match) -> match end)
  end


  @doc """
  Dedupes the spaces within `input`.

      iex> String.Extra.dedupe_spaces("Hello  world   ")
      "Hello world"

  """
  @spec dedupe_spaces(String.t) :: String.t
  def dedupe_spaces(input) do
    String.replace(input, ~r/\s{2,}/, " ")
    |> String.trim()
  end


  @doc """
  Wraps input with wrapper.

  ## Examples

      iex> String.Extra.wrap("test", "\b")
      "\btest\b"

  """
  @spec wrap(String.t, String.t) :: String.t
  def wrap(input, wrapper) when is_binary(input) and is_binary(wrapper) do
    wrapper <> input <> wrapper
  end


  @doc """
  Converts a passed string into a skewered (slug-friendly) one.

  Can pass an option of {:downcase, boolean}. (Defaults to true).

  ## Example

      iex> String.Extra.kebabcase("208 Prospect Park W Brooklyn")
      "208-prospect-park-w-brooklyn"

      iex> String.Extra.kebabcase("208 Prospect Park W Brooklyn", downcase: false)
      "208-Prospect-Park-W-Brooklyn"

  """
  @spec kebabcase(String.t, Keyword.t) :: String.t
  def kebabcase(string, opts \\ [{:downcase, true}]) do
    kebabed =
      string
      |> String.Extra.dedupe_spaces()
      |> String.replace(" ", "-")

    if Keyword.get(opts, :downcase) do
      kebabed |> String.downcase()
    else
      kebabed
    end
  end

  def kebabcase_to_titlecase(input) do
    input
    |> String.split("-")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  def shorthand_name(input) do
    [fname | rest] =
      input
      |> String.split()

    first_initial =
      "#{String.slice(fname, 0, 1)}."

    [first_initial | rest]
    |> Enum.join(" ")
  end
end
