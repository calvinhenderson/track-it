defmodule TrackIt.Repo.Migrations.CreateAssetsTables do
  use Ecto.Migration

  def change do
    create table(:assets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :asset_tag, :citext, null: false
      add :serial_number, :citext
      add :user_id, references(:accounts, type: :binary_id)
      timestamps(type: :utc_datetime)
    end
  end
end
