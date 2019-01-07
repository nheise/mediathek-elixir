defmodule Directory.Cache.FileSystemInitializerTest do
  use ExUnit.Case, async: true

  require Logger

  @test_dir "./test/mediathek/directory/test_dir"
  @cache Directory.Cache.FileSystemInitializer.init(path: @test_dir)

  test "check cache size" do
    assert Map.size(@cache) == 9
  end

  test "check root element in cache" do
    root_item = @cache[{""}]
    #IO.inspect(@cache, label: "cache: ")
    assert root_item.name === ""
    assert root_item.full_path === Path.absname(@test_dir)
    assert root_item.cache_path === ""
    assert root_item.parent_cache_path === ""
    assert root_item.type == :directory
    assert Enum.count(root_item.subs) == 3
  end

  test "check deeper directory" do
    item_path = "dir2/dir21"
    item = @cache[{item_path}]
    assert item.name === "dir21"
    assert item.full_path === Path.absname(Path.join(@test_dir, item_path))
    assert item.cache_path === item_path
    assert item.parent_cache_path === "dir2"
    assert item.type == :directory
    assert Enum.count(item.subs) == 1
  end

  test "check deepest file" do
    item_path = "dir2/dir21/file211"
    item = @cache[{item_path}]
    assert item.name === "file211"
    assert item.full_path === Path.absname(Path.join(@test_dir, item_path))
    assert item.cache_path === item_path
    assert item.parent_cache_path === "dir2/dir21"
    assert item.type == :regular
    assert Enum.count(item.subs) == 0
  end

  test "chech dot file is ignored" do
    assert @cache[{"dir1/.ignore_dot_file"}] === nil
  end

  test "map test" do
    string_key = "bin/dev/key"
    value = :item

    cache = %{}
    cache = Map.put(cache, {string_key}, value)

    assert cache[{string_key}] === value

    test_string_key = "bin/dev/key2"
    assert cache[{test_string_key}] === nil
  end
end
