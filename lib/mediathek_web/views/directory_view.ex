defmodule MediathekWeb.DirectoryView do
  use MediathekWeb, :view

  def render("directory.json", %{directory: directory}) do
    directory
  end
end
