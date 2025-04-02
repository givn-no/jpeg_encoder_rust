defmodule JpegEncoderRust do
  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  use RustlerPrecompiled,
    otp_app: :jpeg_encoder_rust,
    crate: "jpeg_encoder_nif",
    base_url: "#{github_url}/releases/download/v#{version}",
    force_build: System.get_env("JPEG_ENCODER_RUST_BUILD") in ["1", "true"],
    targets:
      Enum.uniq(["aarch64-unknown-linux-musl" | RustlerPrecompiled.Config.default_targets()]),
    version: version

  def encode(_data, _width, _height, _quality) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
