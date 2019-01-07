defmodule Directory.Cache.Initializer do
  @callback init(opts :: []) :: %{}
end
