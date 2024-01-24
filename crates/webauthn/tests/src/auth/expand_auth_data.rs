use cairo_args_runner::{Arg, Felt252};

use super::FeltSerialize;
use crate::{
    auth::ArgsBuilder, Function, FunctionReturnLength, FunctionTrait, FunctionUnspecified,
    SpecifiedResultMemory,
};
use cairo_args_runner::SuccessfulRun;

struct AuthDataFunction;

impl FunctionTrait<AuthenticatorData, Vec<Arg>> for AuthDataFunction {
    fn transform_arguments(&self, args: Vec<Arg>) -> Vec<Arg> {
        args
    }

    fn transform_result(
        &self,
        result: Result<SuccessfulRun, cairo_args_runner::errors::SierraRunnerError>,
    ) -> AuthenticatorData {
        let result = result.unwrap();
        let felts: Vec<Felt252> = result.value;
        let rp_id_hash: Vec<u8> = result.memory
            [felts[0].to_bigint().try_into().unwrap()..felts[1].to_bigint().try_into().unwrap()]
            .iter()
            .map(|x| x.clone().unwrap().to_bigint().try_into().unwrap())
            .collect();
        AuthenticatorData {
            rp_id_hash: rp_id_hash.try_into().unwrap(),
            flags: felts[2].to_bigint().try_into().unwrap(),
            sign_count: felts[3].to_bigint().try_into().unwrap(),
        }
    }

    fn name(&self) -> &str {
        "expand_auth_data_endpoint"
    }
}

const EXPAND_AUTH_DATA: AuthDataFunction = AuthDataFunction;

#[derive(Debug, PartialEq, Clone)]
pub struct AuthenticatorData {
    pub rp_id_hash: [u8; 32],
    pub flags: u8,
    pub sign_count: u32,
}

impl AuthenticatorData {
    pub fn from_bytes(bytes: &[u8]) -> Self {
        let rp_id_hash = bytes[0..32].try_into().unwrap();
        let flags = bytes[32];
        let sign_count = u32::from_be_bytes(bytes[33..37].try_into().unwrap());
        Self {
            rp_id_hash,
            flags,
            sign_count,
        }
    }
}

impl FeltSerialize for AuthenticatorData {
    fn to_felts(self) -> Vec<Felt252> {
        let mut felts: Vec<_> = self.rp_id_hash.iter().cloned().map(Felt252::from).collect();
        felts.push(self.flags.into());
        felts.extend(
            self.sign_count
                .to_be_bytes()
                .iter()
                .cloned()
                .map(Felt252::from),
        );
        felts
    }
}

fn expand_auth_data(auth_data: AuthenticatorData) -> bool {
    let result = EXPAND_AUTH_DATA.run(ArgsBuilder::new().add_array(auth_data.clone().to_felts()).build());
    auth_data == result
}

#[test]
fn test_expand_auth_data_1() {
    let d: Vec<u8> = (0_u8..32_u8).into_iter().collect();
    let auth_data = AuthenticatorData {
        rp_id_hash: d.try_into().unwrap(),
        flags: 0,
        sign_count: 0,
    };
    assert!(expand_auth_data(auth_data));
}
