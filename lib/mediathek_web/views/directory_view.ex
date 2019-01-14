defmodule MediathekWeb.DirectoryView do
  use MediathekWeb, :view

  require Protocol
  Protocol.derive(Jason.Encoder, Directory.CacheItem)

  def render("directory.json", %{directory: directory}) do
    directory
  end
end
