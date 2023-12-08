use starknet::{
    accounts::{Account, Call, ConnectedAccount},
    core::types::FieldElement,
    macros::{felt, selector},
    signers::SigningKey,
};

use crate::{
    deploy_contract::single_owner_account,
    tests::{
        deployment_test::create_account,
        runners::{devnet_runner::DevnetRunner, TestnetRunner},
    },
};

#[derive(Clone)]
struct Session {
    r: FieldElement,
    s: FieldElement,
    session_key: FieldElement,
    session_expires: u64,
    root: FieldElement,
    proof_len: u32,
    proofs: Vec<FieldElement>,
    session_token: Vec<FieldElement>,
}

impl Default for Session {
    fn default() -> Self {
        Self {
            r: felt!("0x42"),
            s: felt!("0x43"),
            session_key: felt!("0x69"),
            session_expires: u64::MAX,
            root: felt!("0x0"),
            proof_len: 1,
            proofs: vec![felt!("44")],
            session_token: vec![felt!("2137")],
        }
    }
}

impl Session {
    fn sign(&mut self, signing: &SigningKey) {
        let hash = FieldElement::from(2137u32);
        let signature = signing.sign(&hash).unwrap();
        self.r = signature.r;
        self.s = signature.s;
        self.session_key = signing.verifying_key().scalar();
    }
}

impl Into<Vec<FieldElement>> for Session {
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

struct CallSequence {
    calls: Vec<[FieldElement; 4]>,
}

impl Default for CallSequence {
    fn default() -> Self {
        Self {
            calls: vec![[FieldElement::default(); 4]],
        }
    }
}

impl Into<Vec<FieldElement>> for CallSequence {
    fn into(self) -> Vec<FieldElement> {
        let mut result = Vec::new();
        result.push(self.calls.len().into());
        result.extend(self.calls.into_iter().flatten());
        result
    }
}

#[tokio::test]
async fn test_validate_session_valid() {
    let runner = DevnetRunner::load();
    let prefunded = runner.prefunded_single_owner_account().await;
    let account = create_account(&prefunded).await;

    let session_key = SigningKey::from_random();
    let mut session = Session::default();
    session.sign(&session_key);

    let call: Vec<FieldElement> = CallSequence::default().into();
    let calldata = vec![session.clone().into(), call]
        .into_iter()
        .flatten()
        .collect();

    let calls = vec![Call {
        to: account.address(),
        selector: selector!("validate_session"),
        calldata,
    }];

    // New account for signing, for signing with the session key
    let session_account =
        single_owner_account(account.provider(), session_key, account.address()).await;

    let session_key_signature = session_account
        .execute(calls.clone())
        .nonce(account.get_nonce().await.unwrap())
        .max_fee(FieldElement::MAX)
        .prepared()
        .unwrap()
        .get_invoke_request(false)
        .await
        .unwrap()
        .signature;

    assert_eq!(session_key_signature.len(), 2);

    // TODO: move signature from parameter as now it's chicken and the egg problem
    //       as we need to sign the calldata
    session.r = session_key_signature[0];
    session.s = session_key_signature[1];

    // Then the original account has to sign session details, and include them as session_token

    account
        .execute(calls)
        .send()
        .await
        .expect("Failed to execute");
}

#[tokio::test]
async fn test_validate_session_revoked() {
    let runner = DevnetRunner::load();
    let prefunded = runner.prefunded_single_owner_account().await;
    let account = create_account(&prefunded).await;

    account
        .execute(vec![Call {
            to: account.address(),
            selector: selector!("revoke_session"),
            calldata: vec![2137u32.into(), u64::MAX.into()],
        }])
        .send()
        .await
        .expect("Failed to execute");

    let signature: Vec<FieldElement> = Session::default().into();
    let call: Vec<FieldElement> = CallSequence::default().into();

    let result = account
        .execute(vec![Call {
            to: account.address(),
            selector: selector!("validate_session"),
            calldata: vec![signature, call].into_iter().flatten().collect(),
        }])
        .send()
        .await;

    assert!(result.is_err());
}
