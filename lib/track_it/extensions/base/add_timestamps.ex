defmodule TrackIt.Extensions.Base.AddTimestamps do
  @moduledoc """
  An extension for adding default timestamps to a resource.
  """
  use Spark.Dsl.Transformer
  alias Spark.Dsl.Transformer

  def transform(dsl_state) do
    if TrackIt.Extensions.Base.Info.timestamps?(dsl_state) do
      {:ok,
       dsl_state
       |> add_attribute_if_not_exists(:create_timestamp, :inserted_at)
       |> add_attribute_if_not_exists(:update_timestamp, :updated_at)}
    else
      {:ok, dsl_state}
    end
  end

  defp add_attribute_if_not_exists(dsl_state, type, name) do
    if Ash.Resource.Info.attribute(dsl_state, name) do
      dsl_state
    else
      {:ok, attribute} =
        Transformer.build_entity(Ash.Resource.Dsl, [:attributes], type, name: name)

      dsl_state
      |> Transformer.add_entity([:attributes], attribute)
    end
  end
end
