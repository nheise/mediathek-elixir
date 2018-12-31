defmodule MediathekWeb.PageController do
  use MediathekWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
