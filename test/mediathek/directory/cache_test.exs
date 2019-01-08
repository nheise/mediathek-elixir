defmodule Directory.CacheTest do
  use ExUnit.Case, async: true

  alias Directory.Cache

  setup do
    cache = start_supervised!(Directory.Cache, fn -> Map.new end )
    %{cache: cache}
  end

  test "check if cache is started", %{cache: cache} do
    assert Directory.Cache.get_item_by("test") === nil
  end
end
