import Config

config :track_it,
  ecto_repos: [TrackIt.Repo]

config :track_it,
  ash_apis: [TrackIt.Accounts]

# Spark formatter configurition

resource_opts = [
  type: Ash.Resource,
  extensions: [TrackIt.Extensions.Base],
  section_order: [
    :base,
    :authentication,
    :token,
    :resource,
    :identities,
    :attributes,
    :relationships,
    :calculations,
    :policies,
    :postgres
  ]
]

config :spark, :formatter,
  remove_parens?: true,
  "Ash.Resource": resource_opts,
  "TrackIt.Resource": resource_opts

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
