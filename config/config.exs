# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :dropbox_web, DropboxWebWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TMHvP4G5qaCMg7M8gzHNXLlyldAhSUXYu8OeNwRdfRT8mF14NtgRameLc3/2AxC2",
  render_errors: [view: DropboxWebWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DropboxWeb.PubSub, adapter: Phoenix.PubSub.PG2]

config :dropbox_api,
  url: System.get_env("DROPBOX_GRAPHQL_HOST") || "http://localhost:8001"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
