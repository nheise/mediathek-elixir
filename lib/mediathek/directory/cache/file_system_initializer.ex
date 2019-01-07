defmodule Directory.Cache.FileSystemInitializer do
  require Logger
  alias Directory.CacheItem
  alias Directory.Cache.ContextUtil

  @spec init( path :: String.t ) :: %{}
  def init( path ) do
    root_path = Path.absname( path )
    Logger.info "Initialize directory cache from: #{root_path}"
    {_, cache, _item} = create_item( { :ok, %{}, CacheItem.create_root( "", root_path, "", "") } )
    cache
  end

  defp create_item( context ) do
    context
    |> add_stats()
    |> get_subs()
    |> add_self_into_cache()
  end

  defp add_self_into_cache( context ) do
    with(
      {:ok, cache, item } <- context
    )
    do
      {:ok, Map.put(cache, {item.cache_path}, item), item }
    else
      {:error, _, _} -> context
    end
  end

  defp add_stats( context ) do
    with(
      {:ok, cache, item } <- context,
      {:ok, stats} <- File.stat(item.full_path) )
      do
        Logger.debug( fn -> "stats from: #{item.full_path}" end )
        Logger.debug( fn -> "type: #{stats.type}, size: #{stats.size}" end )

        {:ok, cache, %{item | size: stats.size, type: stats.type} }
      else
        {:error,_} -> context
      end
  end

  defp get_subs( {_, cache, item } = context ) do
    with(
      {:ok, cache, %{type: :directory} = item } <- context,
      {:ok, files} <- File.ls(item.full_path)
    )
    do
      files = files |> filter_all_dot_files()
      sub_context_list = for file <- files, into: [], do: create_item({:ok, cache, CacheItem.from_parent(item, file)})
      subs = ContextUtil.collect_items(sub_context_list)
      cache = ContextUtil.collect_and_merge_caches(sub_context_list, cache)
      { :ok, cache, %{item | subs: subs } }
    else
      {:ok, cache, item } -> {:ok, cache, item }
      {:error,_} -> {:error, cache, item}
    end
  end

  defp filter_all_dot_files( files ) do
    files |> Enum.filter(&(!String.starts_with?(&1, ".")))
  end

end
