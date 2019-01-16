defmodule MediathekWeb.DirectoryController do
  use MediathekWeb, :controller

  alias Mediathek.Directory.Cache

  def index(conn, _params) do
    call_cache_and_render( conn, "" )
  end

  def show(conn, %{"path" => path}) do
    call_cache_and_render( conn, path )
  end

  defp call_cache_and_render( conn, path )  do
    with directory <- Cache.get_item_by({path}),
      false <- is_nil(directory) do
        render(conn, :directory, directory: directory)
      else
        _-> conn
        |> render(MediathekWeb.ErrorView, :"404")
        |> halt()
      end
  end
end
