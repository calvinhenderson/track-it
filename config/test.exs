import Config

config :track_it, TrackIt.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "track_it#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
