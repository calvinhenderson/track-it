defmodule TrackIt.Assets.AssetTest do
  use TrackIt.DataCase, async: true

  import TrackIt.AssetFixture
  import TrackIt.UserFixture, only: [user_fixture: 0]

  alias TrackIt.Assets.Asset

  describe "create_asset/1" do
    test "creates an asset when given valid params" do
      attrs = valid_asset_attrs()

      assert {:ok, asset} = Asset.create(attrs)
      assert asset.asset_tag == Ash.CiString.new(attrs.asset_tag)
      assert asset.serial_number == Ash.CiString.new(attrs.serial_number)
    end
  end

  describe "check_in/1" do
    setup _ do
      {:ok, %{asset: asset_fixture(), user: user_fixture()}}
    end

    test "clears the owner field", %{asset: asset, user: user} do
      asset = Asset.check_out!(asset, %{user_id: user.id})
      assert asset.user_id

      assert {:ok, asset} = Asset.check_in(asset)
      refute asset.user_id
      refute asset.user
    end
  end

  describe "check_out/2" do
    setup _ do
      {:ok, %{asset: asset_fixture(), user: user_fixture()}}
    end

    test "sets the owner field", %{asset: asset, user: user} do
      refute asset.user_id

      assert {:ok, asset} = Asset.check_out(asset, %{user_id: user.id})
      assert asset.user_id == user.id
      assert asset.user.id == user.id
    end

    test "returns an error when the user does not exist", %{asset: asset} do
      invalid_user_id = Ecto.UUID.generate()

      assert {:error, error} = Asset.check_out(asset, %{user_id: invalid_user_id})

      [not_found_error | _] = error.errors
      assert :user_id in not_found_error.path
    end
  end
end
