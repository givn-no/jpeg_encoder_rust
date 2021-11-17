use jpeg_encoder::{ColorType, Encoder, EncodingError};
use rustler::Atom;

mod atoms {
    rustler::atoms! {
        encoding_error,
        invalid_app_segment,
        app_segment_too_large,
        icc_too_large,
        bad_image_data,
        zero_image_dimensions,
        io_error
    }
}

#[rustler::nif]
fn encode(data: Vec<u8>, width: u16, height: u16, quality: u8) -> Result<Vec<u8>, Atom> {
    let mut result = vec![];
    let encoder = Encoder::new(&mut result, quality);

    return match encoder.encode(&data, width, height, ColorType::Rgb) {
        Ok(()) => Ok(result),
        Err(EncodingError::InvalidAppSegment(..)) => Err(atoms::invalid_app_segment()),
        Err(EncodingError::AppSegmentTooLarge(..)) => Err(atoms::app_segment_too_large()),
        Err(EncodingError::IccTooLarge(..)) => Err(atoms::icc_too_large()),
        Err(EncodingError::BadImageData { .. }) => Err(atoms::bad_image_data()),
        Err(EncodingError::ZeroImageDimensions { .. }) => Err(atoms::zero_image_dimensions()),
        Err(EncodingError::IoError(..)) => Err(atoms::io_error()),
        Err(_err) => Err(atoms::encoding_error()),
    };
}

rustler::init!("Elixir.JpegEncoderRust", [encode]);
