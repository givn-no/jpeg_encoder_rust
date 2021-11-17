defmodule JpegEncoderRust do
  use Rustler, otp_app: :jpeg_encoder_rust, crate: "jpeg_encoder_nif"

  def encode(_data, _width, _height, _quality) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
