defmodule TrackIt.Accounts.Token do
  use TrackIt.Resource,
    extensions: [AshAuthentication.TokenResource],
    data_layer: AshPostgres.DataLayer

  base do
    timestamps?(false)
  end

  token do
    api TrackIt.Accounts
  end

  postgres do
    table "accounts_tokens"
    repo TrackIt.Repo
  end

  policies do
    bypass AshAuthentication.Checks.AshAuthenticationInteraction do
      authorize_if always()
    end
  end
end
