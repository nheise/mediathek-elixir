defmodule Directory.CacheItem do
  alias __MODULE__
  @enforce_keys [:full_path, :cache_path, :parent_cache_path, :name]
  defstruct full_path: nil, cache_path: nil, parent_cache_path: nil, name: "", type: :regular, size: 0, subs: []

  @type t :: %CacheItem{full_path: String.t, cache_path: String.t, parent_cache_path: String.t, name: String.t, type: :regular | :directory, size: integer, subs: list}

  @spec create_root(
          String.t,
          String.t,
          String.t,
          String.t
        ) :: CacheItem.t
  def create_root( name, root_path, cache_path, parent_cache_path ) do
    full_path = Path.join(root_path, cache_path)
    %CacheItem{ name: name, full_path: full_path, cache_path: cache_path, parent_cache_path: parent_cache_path }
  end

  @spec from_parent( CacheItem.t, String.t ) :: CacheItem.t
  def from_parent( parent, name ) do
    full_path = Path.join(parent.full_path, name)
    cache_path = Path.join(parent.cache_path, name)
    parent_cache_path = parent.cache_path
    %CacheItem{ name: name, full_path: full_path, cache_path: cache_path, parent_cache_path: parent_cache_path }
  end
end
