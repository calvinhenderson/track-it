defmodule TrackIt.Accounts.Validations.Email do
  use Ash.Resource.Validation

  def init(opts) do
    {:ok, opts}
  end

  def validate(changeset, opts) do
    field = Keyword.get(opts, :email_field, :email)
    email = Ash.Changeset.get_attribute(changeset, field)

    if Regex.match?(~r/^[^\s]+@[^\s]+$/, email.string) do
      :ok
    else
      {:error, field: field, message: "must contain the @ symbol and no spaces"}
    end
  end
end
