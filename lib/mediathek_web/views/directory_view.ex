defmodule MediathekWeb.DirectoryView do
  use MediathekWeb, :view

  require Protocol
  Protocol.derive(Jason.Encoder, Directory.CacheItem)

  def render("directory.json", %{directory: directory}) do
    directory
    |> remove_second_sub_directory_level()
  end

  defp remove_second_sub_directory_level( directory ) do
    directory
    |> Map.get( :subs )
    |> Enum.map( &(%{ &1 | subs: [] }) )
    |> update_directory_subs( directory )
  end

  defp update_directory_subs( subs, directory ) do
    %{ directory | subs: subs }
  end
end
