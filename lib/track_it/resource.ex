defmodule TrackIt.Resource do
  @doc """
  The base resource.

  ## Usage

      defmodule TrackIt.Api.MyResource do
        use TrackIt.Resource
      end

      defmodule TrackIt.Api.MyResource do
        use TrackIt.Resource

        base do
          timestamps? false
        end
      end

  """
  @default_extensions [
    TrackIt.Extensions.Base
  ]

  @default_authorizers [
    Ash.Policy.Authorizer
  ]

  defmacro __using__(opts) do
    opts =
      opts
      |> Keyword.update(:extensions, @default_extensions, &(@default_extensions ++ &1))
      |> Keyword.update(:authorizers, @default_authorizers, &(@default_authorizers ++ &1))

    quote do
      use Ash.Resource, unquote(opts)
    end
  end
end
