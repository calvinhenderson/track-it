defmodule TrackIt.Accounts.User do
  use TrackIt.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication]

  AshAuthentication.Strategy.Password.Actions

  authentication do
    api TrackIt.Accounts

    strategies do
      password :password do
        identity_field :email
        confirmation_required? false
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

  actions do
    create :register_with_password do
      primary? true

      accept [:email]
      argument :password, :string, allow_nil?: false, sensitive?: true

      validate TrackIt.Accounts.Validations.Email
      validate TrackIt.Accounts.Validations.Password

      change set_context(%{strategy_name: :password})
      change AshAuthentication.Strategy.Password.HashPasswordChange
      change AshAuthentication.GenerateTokenChange
    end

    update :reset_password do
      accept []

      argument :old_password, :string, allow_nil?: false, sensitive?: true
      argument :password, :string, allow_nil?: false, sensitive?: true

      change set_context(%{strategy_name: :password})

      validate TrackIt.Accounts.Validations.Password

      validate {AshAuthentication.Strategy.Password.PasswordValidation,
                password_argument: :old_password}

      change AshAuthentication.Strategy.Password.HashPasswordChange
    end

    defaults [:read]
  end

  code_interface do
    define_for TrackIt.Accounts
    define :register_with_password, action: :register_with_password
    define :reset_password, action: :reset_password
    define :sign_in, action: :sign_in_with_password
  end

  postgres do
    table "accounts"
    repo TrackIt.Repo
  end

  policies do
    bypass AshAuthentication.Checks.AshAuthenticationInteraction do
      authorize_if always()
    end
  end
end
