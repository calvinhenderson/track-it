defmodule TrackIt.AssetFixture do
  alias TrackIt.Assets.Asset

  @doc """
  A helper method for creating and overriding valid asset attributes.
  """
  def valid_asset_attrs(params \\ %{}) do
    Enum.into(params, %{
      asset_tag: "#{System.unique_integer([:positive])}",
      serial_number: "#{System.unique_integer([:positive])}"
    })
  end

  @doc """
  A helper method for creating asset accounts.
  """
  def asset_fixture(params \\ %{}) do
    valid_asset_attrs(params)
    |> Asset.create!()
  end
end
