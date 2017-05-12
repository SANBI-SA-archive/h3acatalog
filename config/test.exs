use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :h3acatalog, H3acatalog.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :h3acatalog, H3acatalog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: System.get_env("POSTGRES_PASS"),
  database: "h3acatalog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configures mailer for testing
config :h3acatalog, H3acatalog.Mailer,
  adapter: Bamboo.TestAdapter
