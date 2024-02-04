defmodule TrackIt.Repo.Migrations.CreateAccountsTables do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext", "")

    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: false
      add :hashed_password, :binary, null: false
      timestamps(type: :utc_datetime)
    end

    create table(:accounts_tokens, primary_key: false) do
      add :jti, :binary, primary_key: true
      add :subject, :string, null: false
      add :purpose, :string, null: false
      add :extra_data, :map
      add :created_at, :utc_datetime, null: false
      add :expires_at, :utc_datetime, null: false
    end
  end
end
