defmodule Directory.CacheTest do
  use ExUnit.Case, async: true

  setup do
    cache = start_supervised!({Directory.Cache, (fn -> %{} end)} )
    %{cache: cache}
  end

  test "check if cache is started", %{cache: _cache} do
    assert Directory.Cache.get_item_by({"test"}) === nil
  end
end
