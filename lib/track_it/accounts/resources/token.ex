defmodule TrackIt.Accounts.Token do
  use TrackIt.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource]
  
  base do
    timestamps? false
  end

  token do
    api TrackIt.Accounts
  end

  postgres do
    table "accounts_tokens"
    repo TrackIt.Repo
  end

  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
