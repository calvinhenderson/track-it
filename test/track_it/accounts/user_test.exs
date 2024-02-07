defmodule TrackIt.Accounts.UserTest do
  use TrackIt.DataCase

  alias TrackIt.Accounts

  describe "register_with_password/1" do
    test "registers a user" do
      attrs = valid_user_attributes()
      {:ok, user} = Accounts.User.register_with_password(attrs)

      assert attrs.email == user.email.string
    end

    test "validates fields" do
      attrs = %{email: "invalid-email", password: "too short"}
      {:error, errors} = Accounts.User.register_with_password(attrs)

      assert "must contain the @ symbol and no spaces" in errors_on(errors).email
      assert "must contain at least 12 characters" in errors_on(errors).password
    end
  end

  defp valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: "test_user#{System.unique_integer()}@example.com",
      password: "valid password"
    })
  end
end
