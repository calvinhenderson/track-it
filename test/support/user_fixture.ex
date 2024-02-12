defmodule TrackIt.UserFixture do
  alias TrackIt.Accounts.User

  @doc """
  A helper method for creating and overriding valid user attributes.
  """
  def valid_user_attrs(params \\ %{}) do
    Enum.into(params, %{
      email: "user_#{System.unique_integer()}@example.com",
      password: "valid password"
    })
  end

  @doc """
  A helper method for creating user accounts.
  """
  def user_fixture(params \\ %{}) do
    valid_user_attrs(params)
    |> User.register_with_password!()
  end
end
