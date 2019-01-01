defmodule Directotry.Cache do
  require Logger

  @spec init(path :: String.t ) :: %{}
  def init(path) do
    abs_path = Path.absname(path)
    Logger.info "Initialize directory cache from: #{abs_path}"
    %{}
  end
end
