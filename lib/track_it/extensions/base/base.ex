defmodule TrackIt.Extensions.Base do
  @base %Spark.Dsl.Section{
    name: :base,
    describe: """
    Configure the behavior of the base extension.
    """,
    examples: [
      """
      base do
        timestamps? false
      end
      """
    ],
    schema: [
      timestamps?: [
        type: :boolean,
        doc: "Set to false to skip adding timestamps",
        default: true
      ]
    ]
  }

  defmodule Info do
    def timestamps?(resource) do
      Spark.Dsl.Extension.get_opt(resource, [:base], :timestamps?, true)
    end
  end

  use Spark.Dsl.Extension,
    transformers: [TrackIt.Extensions.Base.AddTimestamps],
    sections: [@base]
end
