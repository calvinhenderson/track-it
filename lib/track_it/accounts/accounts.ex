defmodule TrackIt.Accounts do
  use Ash.Api

  resources do
    resource TrackIt.Accounts.User
    resource TrackIt.Accounts.Token
  end
end
