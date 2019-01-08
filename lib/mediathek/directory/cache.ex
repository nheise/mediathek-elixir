defmodule Directory.Cache do
  use Agent
  alias __MODULE__

  @spec start_link((() -> %{})) :: {:error, any()} | {:ok, pid()}
  def start_link(init_fun) do
    Agent.start_link(init_fun, name: __MODULE__)
  end

  @doc """
    Gets an item out of the cache by its key.
  """
  @spec get_item_by(key :: String.t) :: Directory.CacheItem.t
  def get_item_by( key ) do
    Agent.get(Cache, fn cache -> Map.get(cache, key) end )
  end
end
