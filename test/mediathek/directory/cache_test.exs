defmodule Mediathek.Directory.CacheTest do
  use ExUnit.Case, async: true

  alias Mediathek.Directory.Cache

  setup do
    cache = start_supervised!({Cache, (fn -> %{} end)} )
    %{cache: cache}
  end

  test "check if cache is started", %{cache: _cache} do
    assert Cache.get_item_by({"test"}) === nil
  end
end
