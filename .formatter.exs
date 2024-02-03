# Used by "mix format"
[
  import_deps: [:ash, :ash_postgres, :ash_authentication],
  plugins: [Spark.Formatter],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"]
]
