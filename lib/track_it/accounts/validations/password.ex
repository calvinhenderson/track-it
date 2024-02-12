defmodule TrackIt.Accounts.Validations.Password do
  @moduledoc """
  A convenience validation for checking that a
  password meets the complexity requirements.

  ## Options

  - `:password_argument` - The argument to perform the validation on. Defaults to `:password`.

  ## Examples

      action ... do
        ...
        argument :password, :string, ...
        validate TrackIt.Accounts.Validations.Password
        ...
      end

      action ... do
        ...
        argument :new_password, :string, ...
        validate {TrackIt.Accounts.Validations.Password, password_argument: :new_password}
        ...
      end
  """
  def init(opts) do
    {:ok, opts}
  end

  def validate(changeset, opts) do
    field = Keyword.get(opts, :password_argument, :password)
    password = Ash.Changeset.get_argument(changeset, field)

    if String.length(password) < 12 do
      {:error, field: field, message: "must contain at least 12 characters"}
    else
      :ok
    end
  end
end
