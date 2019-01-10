defmodule MediathekWeb.DirectoryController do
  use MediathekWeb, :controller

  alias Mediathek.Directory.Cache

  def index(conn, _params) do
    directory = Cache.get_item_by({""})

    render(conn, :directory, directory: directory)
  end

  def show(conn, %{"path" => path}) do
    directory = Cache.get_item_by({path})

    render(conn, :directory, directory: directory)
  end
end
