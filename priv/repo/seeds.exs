# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TrackIt.Repo.insert!(%TrackIt.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
TrackIt.Accounts.User.register_with_password!(%{email: "test_account@localhost", password: "valid password"})
TrackIt.Assets.Asset.create!(%{asset_tag: "1234", serial_number: "ABCD123"})
