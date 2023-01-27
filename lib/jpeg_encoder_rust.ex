defmodule JpegEncoderRust do
  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  targets = ~w(
    arm-unknown-linux-gnueabihf
    aarch64-apple-darwin
    aarch64-unknown-linux-gnu
    aarch64-unknown-linux-musl
    x86_64-apple-darwin
    x86_64-pc-windows-gnu
    x86_64-pc-windows-msvc
    x86_64-unknown-linux-gnu
    x86_64-unknown-linux-musl
  )

  use RustlerPrecompiled,
    otp_app: :jpeg_encoder_rust,
    crate: "jpeg_encoder_nif",
    base_url: "#{github_url}/releases/download/v#{version}",
    force_build: System.get_env("JPEG_ENCODER_RUST_BUILD") in ["1", "true"],
    version: version,
    targets: targets

  def encode(_data, _width, _height, _quality) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
