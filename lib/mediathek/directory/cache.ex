defmodule Directory.Cache do
  @doc """
    Gets an item out of the cache by its key.
  """
  @callback get_item_by(key :: String.t) :: Directory.CacheItem.t
end
