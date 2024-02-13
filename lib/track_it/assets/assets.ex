defmodule TrackIt.Assets do
  @moduledoc """
  Provides an API for interacting with assets.
  """
  use Ash.Api

  resources do
    resource TrackIt.Assets.Asset
  end
end
