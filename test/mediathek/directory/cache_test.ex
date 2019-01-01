defmodule Directotry.CacheTest do
  use ExUnit.Case, async: true

  @test_dir "./test/mediathek/directory/test_dir"
  @directory_cache Directotry.Cache.init(@test_dir)

  test "check directories count" do

    assert @directory_cache === %{}

  end
end
