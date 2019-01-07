defmodule Directory.Cache.ContextUtil do
  alias Directory.CacheItem

  @type cache_item_context :: { atom, map, CacheItem.t }

  @spec collect_and_merge_caches([cache_item_context], map) :: [map]
  def collect_and_merge_caches( context_list, cache ) do
    context_list
      |> collect_into_list( fn {_, map, _item} -> map end )
      |> merge_caches( cache )
  end

  @spec collect_items([cache_item_context]) :: [CacheItem.t]
  def collect_items( context_list ) do
    context_list |> collect_into_list( fn {_, _, item} -> item end )
  end

  defp merge_caches( caches, cache ) do
    Enum.reduce(caches, cache, fn map, main -> Map.merge(main, map) end )
  end

  defp collect_into_list( enumerable, fun ) do
    enumerable
      |> Enum.reduce([], fn(x, acc) -> [fun.(x) | acc] end)
      |> Enum.reverse
  end
end
