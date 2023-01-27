defmodule JpegEncoderRust.MixProject do
  use Mix.Project

  @source_url "https://github.com/hooplab/jpeg_encoder_rust"
  @version "0.2.0"

  def project do
    [
      app: :jpeg_encoder_rust,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native/jpeg_encoder_nif/.cargo",
        "native/jpeg_encoder_nif/src",
        "native/jpeg_encoder_nif/Cargo*",
        "checksum-*.exs",
        "mix.exs"
      ],
      links: %{"GitHub" => @source_url}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.5"},
      {:rustler, ">= 0.0.0", optional: true}
    ]
  end
end
