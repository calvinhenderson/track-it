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

  defmacro __using__(opts) do
    quote do
      use Ash.Resource,
          unquote(
            Keyword.update(opts, :extensions, @default_extensions, &(@default_extensions ++ &1))
          )
    end
  end
end
