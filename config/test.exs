import Config

config :track_it, TrackIt.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "track_it_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# Disable async tasks in ash
config :ash, :disable_async?, true

# Ignore missed notification warnings
config :ash, :missed_notifications, :ignore

# This is the secret used to sign auth tokens
config :track_it, token_signing_secret: "secret"
