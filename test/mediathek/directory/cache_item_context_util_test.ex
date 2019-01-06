defmodule Directory.CacheItem.ContextUtilTest do
  use ExUnit.Case, async: true

  alias Directory.CacheItem.ContextUtil

  @context_list [ {:ok, %{b: "b"}, :item1 }, {:ok, %{c: "c",d: "d"}, :item2 } ]

  test "collect all items from context list" do
    item_list = ContextUtil.collect_items( @context_list )

    assert item_list === [:item1, :item2]
  end

  test "collect all caches and merge them" do
    cache = %{a: "a"}

    merged_cache = ContextUtil.collect_and_merge_caches(@context_list, cache)

    assert merged_cache === %{a: "a",b: "b",c: "c",d: "d"}

  end

end
