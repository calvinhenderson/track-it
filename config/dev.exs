import Config

config :track_it, TrackIt.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "track_it_dev",
  port: 5432,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# This is the secret used to sign auth tokens
config :track_it, token_signing_secret: "JSQ+xpymJB0="
