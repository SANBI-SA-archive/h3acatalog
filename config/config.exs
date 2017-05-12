# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :h3acatalog,
  ecto_repos: [H3acatalog.Repo]

# Configures the endpoint
config :h3acatalog, H3acatalog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MxOVfNpCSrrf6JOWhuzR110xY74ZGR22r9zt9A8KZjE6V4tDaRllmFxEemdBbMQ6",
  render_errors: [view: H3acatalog.ErrorView, accepts: ~w(html json)],
  pubsub: [name: H3acatalog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures mailer
config :h3acatalog, H3acatalog.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: ""

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
