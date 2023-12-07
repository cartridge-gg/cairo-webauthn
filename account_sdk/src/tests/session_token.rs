use std::time::Duration;

use starknet::{
    accounts::{Account, Call},
    core::types::FieldElement,
    macros::{felt, selector},
};
use tokio::time::sleep;

use crate::tests::{
    deployment_test::create_account,
    runners::{devnet_runner::DevnetRunner, TestnetRunner},
};

struct Signature {
    r: FieldElement,
    s: FieldElement,
    session_key: FieldElement,
    session_expires: u64,
    root: FieldElement,
    proof_len: u32,
    proofs: Vec<FieldElement>,
    session_token: Vec<FieldElement>,
}

impl Into<Vec<FieldElement>> for Signature {
    fn into(self) -> Vec<FieldElement> {
        let mut result = Vec::new();
        result.push(self.r);
        result.push(self.s);
        result.push(self.session_key);
        result.push(self.session_expires.into());
        result.push(self.root);
        result.push(self.proof_len.into());
        result.push(self.proofs.len().into());
        result.extend(self.proofs);
        result.push(self.session_token.len().into());
        result.extend(self.session_token);
        result
    }
}

#[tokio::test]
async fn test_authorize_execute() {
    let runner = DevnetRunner::load();
    let prefunded = runner.prefunded_single_owner_account().await;
    let account = create_account(&prefunded).await;

    let signature = Signature {
        r: felt!("0x42"),
        s: felt!("0x43"),
        session_key: felt!("0x69"),
        session_expires: u64::MAX,
        root: felt!("0x0"),
        proof_len: 1,
        proofs: vec![felt!("2137")],
        session_token: vec![felt!("2137")],
    };

    let call = vec![
        felt!("1"),
        felt!("0x1000"),
        felt!("0x1001"),
        felt!("0x1002"),
        felt!("0x1003"),
    ];

    let signature: Vec<FieldElement> = signature.into();
    let calldata = signature.into_iter().chain(call).collect();

    sleep(Duration::from_millis(100)).await;

    account
        .execute(vec![Call {
            to: account.address(),
            selector: selector!("validate_session"),
            calldata,
        }])
        .send()
        .await
        .expect("Failed to execute");
}
