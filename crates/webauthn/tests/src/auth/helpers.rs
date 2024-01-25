use cairo_args_runner::{errors::SierraRunnerError, Arg, Felt252};

use super::CairoU256;
use crate::{auth::ArgsBuilder, FunctionTrait};
use cairo_args_runner::SuccessfulRun;

struct Extractu256Fromu8ArrayFunction;

impl FunctionTrait<Option<CairoU256>, (Vec<u8>, usize)> for Extractu256Fromu8ArrayFunction {
    fn transform_arguments(&self, args: (Vec<u8>, usize)) -> Vec<Arg> {
        ArgsBuilder::new().add_array(args.0).add_one(args.1).build()
    }

    fn transform_result(
        &self,
        result: Result<SuccessfulRun, SierraRunnerError>,
    ) -> Option<CairoU256> {
        let result = result.unwrap();
        let felts: Vec<Felt252> = result.value;
        if felts[0] == Felt252::from(1) {
            None
        } else {
            Some(CairoU256 {
                low: felts[1].clone(),
                high: felts[2].clone(),
            })
        }
    }

    fn name(&self) -> &str {
        "extract_u256_from_u8_array_endpoint"
    }
}

const EXTRACT_U256_FROM_U8_ARRAY: Extractu256Fromu8ArrayFunction = Extractu256Fromu8ArrayFunction;

fn serialize_and_extract_u256(val: CairoU256, offset: usize) -> CairoU256 {
    let low = val.low.to_bytes_be();
    let high = val.high.to_bytes_be();

    let bytes = [
        vec![0; offset + 16 - high.len()],
        high,
        vec![0; 16 - low.len()],
        low,
    ]
    .concat();
    let result = EXTRACT_U256_FROM_U8_ARRAY.run((bytes, offset));
    result.unwrap()
}

#[test]
fn test_extract_u256_from_u8_array_1() {
    let result = EXTRACT_U256_FROM_U8_ARRAY.run(([0u8; 32].to_vec(), 0));
    assert_eq!(result, Some(CairoU256::zero()));
}

#[test]
fn test_extract_u256_from_u8_array_2() {
    let val = CairoU256 {
        low: Felt252::from(12345),
        high: Felt252::from(98765),
    };
    assert_eq!(serialize_and_extract_u256(val.clone(), 0), val);
}

#[test]
fn test_extract_u256_from_u8_array_fail_1() {
    let result = EXTRACT_U256_FROM_U8_ARRAY.run(([0u8; 32].to_vec(), 3));
    assert_eq!(result, None);
}
