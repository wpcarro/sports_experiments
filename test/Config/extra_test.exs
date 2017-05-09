defmodule Config.ExtraTest do
  use ExUnit.Case


  describe "from_file/3" do

    setup do
      path =
        "/tmp/secrets.txt"

      secret_content = """
      consumer_key=VALUE
      another_key=ANOTHER_VALUE
      """

      File.write!(path, secret_content)

      on_exit fn ->
        File.rm!(path)
      end

      {:ok, %{path: path}}
    end

    test "works", %{path: path} do
      assert Config.Extra.from_file(path, "consumer_key") ==
        "VALUE"

      assert Config.Extra.from_file(path, "another_key") ==
        "ANOTHER_VALUE"
    end
  end
end
