# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :mediathek, MediathekWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UEw6vJZQLo2UcNhyYnKDcvrA1c0xs7dvR8+sq8Yu3mjun3l6TKB8bad4SDr86Ao0",
  render_errors: [view: MediathekWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mediathek.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
