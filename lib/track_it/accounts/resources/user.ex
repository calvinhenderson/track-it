defmodule TrackIt.Accounts.User do
  use TrackIt.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication]

  authentication do
    api TrackIt.Accounts

    strategies do
      password :password do
        identity_field :email
      end
    end

    tokens do
      enabled? true
      token_resource TrackIt.Accounts.Token

      signing_secret fn _, _ ->
        Application.fetch_env(:track_it, :token_signing_secret)
      end
    end
  end

  identities do
    identity :unique_email, [:email]
  end

  attributes do
    uuid_primary_key :id
    attribute :email, :ci_string, allow_nil?: false
    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  postgres do
    table "accounts"
    repo TrackIt.Repo
  end

  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
