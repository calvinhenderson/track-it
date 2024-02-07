defmodule TrackIt.Accounts.Validations.Password do
  def init(opts) do
    {:ok, opts}
  end

  def validate(changeset, opts) do
    field = Keyword.get(opts, :password_field, :password)
    password = Ash.Changeset.get_argument(changeset, field)

    if String.length(password) < 12 do
      {:error, field: field, message: "must contain at least 12 characters"}
    else
      :ok
    end
  end
end
