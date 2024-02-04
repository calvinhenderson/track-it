defmodule TrackIt.Accounts.UserTest do
  use TrackIt.DataCase

  alias TrackIt.Accounts

  describe "register_with_password/1" do
    test "registers a user" do
      attrs = valid_user_attributes()
      {:ok, user} = Accounts.User.register_with_password(attrs)

      assert attrs.email == user.email.string
    end
  end

  defp valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: "test_user#{System.unique_integer()}@example.com",
      password: "valid password"
    })
  end
end
