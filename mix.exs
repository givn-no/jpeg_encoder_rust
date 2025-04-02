defmodule JpegEncoderRust.MixProject do
  use Mix.Project

  @source_url "https://github.com/givn-no/jpeg_encoder_rust"
  @version "0.4.0"

  def project do
    [
      app: :jpeg_encoder_rust,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      hex: hex(),
      description: "jpeg encoder implemented as a rust nif"
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
      links: %{"GitHub" => @source_url},
      licenses: ["MIT"]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:rustler_precompiled, ">= 0.0.0"},
      {:rustler, ">= 0.0.0", optional: true}
    ]
  end

  defp hex do
    [
      api_url: System.get_env("HEX_API_URL"),
      api_key: System.get_env("HEX_API_KEY")
    ]
  end
end
