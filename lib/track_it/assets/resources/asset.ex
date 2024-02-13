defmodule TrackIt.Assets.Asset do
  @moduledoc """
  Provides an asset resource.
  Assets must have a unique asset tag.
  """
  use TrackIt.Resource,
    authorizers: [Ash.Policy.Authorizer],
    data_layer: AshPostgres.DataLayer

  identities do
    identity :unique_asset_tag, [:asset_tag]
  end

  attributes do
    uuid_primary_key :id
    attribute :asset_tag, :ci_string, allow_nil?: false
    attribute :serial_number, :ci_string
  end

  relationships do
    belongs_to :user, TrackIt.Accounts.User, api: TrackIt.Accounts
  end

  actions do
    update :check_in do
      accept []
      change set_attribute(:user_id, nil)
      change load(:user)
    end

    update :check_out do
      argument :user_id, :uuid, allow_nil?: false
      change manage_relationship(:user_id, :user, type: :append_and_remove)
      change load(:user)
    end

    defaults [:create, :read, :update, :destroy]
  end

  actions do
    read :for_user do
      argument :user_id, :string, allow_nil?: false
      filter expr(user_id == ^arg(:user_id))
    end
  end

  code_interface do
    define_for TrackIt.Assets
    define :create, action: :create
    define :check_in, action: :check_in
    define :check_out, action: :check_out
  end

  calculations do
    calculate :is_available, :boolean, expr(user_id == nil)
  end

  preparations do
    prepare build(load: [:user])
  end

  postgres do
    repo TrackIt.Repo
    table "assets"
  end
end
