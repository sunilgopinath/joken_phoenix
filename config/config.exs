# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :joken_phoenix,
  ecto_repos: [JokenPhoenix.Repo]

# Configures the endpoint
config :joken_phoenix, JokenPhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EENdc7AF7x8eBj3UlFO38HStlq+gQTRCuj0jXUqBvkm7CuKIu/bU795odKT0vqNI",
  render_errors: [view: JokenPhoenix.ErrorView, accepts: ~w(json)],
  pubsub: [name: JokenPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :joken_phoenix, :auth0,
  app_baseurl: "http://localhost",
  app_id: "elixir-demo",
  app_secret: "elixir-demo"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
