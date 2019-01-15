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
    case Cache.get_item_by({path}) do
      nil -> send_resp(conn, 404, "Not found")
      directory -> render(conn, :directory, directory: directory)
    end

  end
end
