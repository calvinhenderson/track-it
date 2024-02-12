defmodule TrackIt.Repo do
  use AshPostgres.Repo, otp_app: :track_it

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
