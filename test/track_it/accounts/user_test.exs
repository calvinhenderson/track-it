defmodule TrackIt.Accounts.UserTest do
  use TrackIt.DataCase, async: true

  alias TrackIt.Accounts
  import TrackIt.UserFixture

  setup _tags do
    %{user: user_fixture()}
  end

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

  describe "reset_password/2" do
    test "resets the user's password when given valid params" do
      original_password = "valid password"
      user = user_fixture(%{password: original_password})

      assert {:ok, user} =
               Accounts.User.reset_password(user, %{
                 old_password: original_password,
                 password: "new valid password"
               })
    end

    test "old password must match", %{user: user} do
      {:error, %{errors: errors}} =
        Accounts.User.reset_password(user, %{
          old_password: "does not match",
          password: "new valid password"
        })

      assert [%AshAuthentication.Errors.AuthenticationFailed{field: :old_password}] = errors
    end

    test "validates new password" do
      original_password = "valid password"
      user = user_fixture(%{password: original_password})

      {:error, errors} =
        Accounts.User.reset_password(user, %{
          old_password: original_password,
          password: "too short"
        })

      assert "must contain at least 12 characters" in errors_on(errors).password
    end
  end

  describe "sign_in/1" do
    test "returns a user when given a valid email and password combo" do
      attrs = valid_user_attrs()
      %{id: user_id} = user = user_fixture(attrs)

      assert {:ok, %{id: user_id}} =
               Accounts.User.sign_in(%{
                 email: attrs.email,
                 password: attrs.password
               })
    end
  end

  defp valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: "test_user#{System.unique_integer()}@example.com",
      password: "valid password"
    })
  end
end
