defmodule MediathekWeb.DirectoryControllerTest do
  use MediathekWeb.ConnCase

  alias Mediathek.Directory.Cache
  alias Directory.CacheItem

  @root_item %CacheItem{
    full_path: "fullPath",
    cache_path: "",
    parent_cache_path: "",
    name: "",
    type: :directory,
    size: 5,
    subs: []
  }
  @cache %{
    {""} => @root_item
  }

  describe "GET /directory" do
    setup [:create_cache]

    test "Response with root path", %{conn: conn, cache: _cache} do

      #IO.inspect(conn)

      response =
        conn
        |> get(Routes.directory_path(conn, :index))
        |> json_response(200)

      expected = %{
        "cache_path" => "",
        "full_path" => "fullPath",
        "name" => "",
        "parent_cache_path" => "",
        "size" => 5,
        "subs" => [],
        "type" => "directory"
      }
      #IO.inspect(response)

      assert response == expected
    end
  end

  defp create_cache(_) do
    cache = start_supervised!({Cache, (fn -> @cache end)} )
    {:ok, cache: cache}
  end
end
