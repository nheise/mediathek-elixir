defmodule MediathekWeb.DirectoryControllerTest do
  use MediathekWeb.ConnCase

  alias Mediathek.Directory.Cache
  alias Directory.CacheItem

  @sub_sub_dir %CacheItem{
    full_path: "/fullPath/sub_dir/sub_dir",
    cache_path: "sub_dir/sub_dir",
    parent_cache_path: "sub_dir",
    name: "sub_dir",
    type: :directory,
    size: 5,
    subs: []
  }

  @sub_dir %CacheItem{
    full_path: "/fullPath/sub_dir",
    cache_path: "sub_dir",
    parent_cache_path: "",
    name: "sub_dir",
    type: :directory,
    size: 5,
    subs: [@sub_sub_dir]
  }

  @sub_file %CacheItem{
    full_path: "/fullPath/sub_file",
    cache_path: "sub_file",
    parent_cache_path: "",
    name: "sub_file",
    type: :regular,
    size: 5,
    subs: []
  }

  @root_item %CacheItem{
    full_path: "/fullPath",
    cache_path: "",
    parent_cache_path: "",
    name: "",
    type: :directory,
    size: 5,
    subs: [@sub_dir, @sub_file]
  }
  @cache %{
    {""} => @root_item,
    {"sub_dir/sub_dir"} => @sub_dir
  }

  @expected_sub_dir %{
    "cache_path" => "sub_dir",
    "full_path" => "/fullPath/sub_dir",
    "name" => "sub_dir",
    "parent_cache_path" => "",
    "size" => 5,
    "type" => "directory",
    "subs" => [
      %{
        "cache_path" => "sub_dir/sub_dir",
        "full_path" => "/fullPath/sub_dir/sub_dir",
        "name" => "sub_dir",
        "parent_cache_path" => "sub_dir",
        "size" => 5,
        "subs" => [],
        "type" => "directory"
      }
    ]
  }

  @expected_root %{
    "cache_path" => "",
    "name" => "",
    "parent_cache_path" => "",
    "size" => 5,
    "type" => "directory",
    "full_path" => "/fullPath",
    "subs" => [
      %{
        "cache_path" => "sub_dir",
        "full_path" => "/fullPath/sub_dir",
        "name" => "sub_dir",
        "parent_cache_path" => "",
        "size" => 5,
        "subs" => [],
        "type" => "directory"
      },
      %{
        "cache_path" => "sub_file",
        "full_path" => "/fullPath/sub_file",
        "name" => "sub_file",
        "parent_cache_path" => "",
        "size" => 5,
        "subs" => [],
        "type" => "regular"
      }
    ]
  }

  describe "GET /directory" do
    setup [:create_cache]

    test "Response with root path", %{conn: conn, cache: _cache} do
      # IO.inspect(conn)

      response =
        conn
        |> get(Routes.directory_path(conn, :index))
        |> json_response(200)

      # IO.inspect(response)

      assert response == @expected_root
    end

    test "Response with path", %{conn: conn, cache: _cache} do
      # IO.inspect(conn)

      response =
        conn
        |> get(Routes.directory_path(conn, :show, "sub_dir/sub_dir"))
        |> json_response(200)

      # IO.inspect(response)

      assert response == @expected_sub_dir
    end

    test "Response with 404 when not found", %{conn: conn, cache: _cache} do
      # IO.inspect(conn)

      response =
        conn
        |> get(Routes.directory_path(conn, :show, "not_found"))
        |> json_response(404)

      IO.inspect(response)

      assert response == @expected_sub_dir
    end
  end

  defp create_cache(_) do
    cache = start_supervised!({Cache, fn -> @cache end})
    {:ok, cache: cache}
  end
end
