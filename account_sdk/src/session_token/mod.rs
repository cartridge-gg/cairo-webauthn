mod account;
mod sequence;
mod session;
mod signature;

pub use account::SessionAccount;
pub use sequence::CallSequence;
pub use session::Session;
pub use signature::SessionSignature;
use starknet::{core::types::FieldElement, macros::felt};

pub const SIGNATURE_TYPE: FieldElement = felt!("0x53657373696f6e20546f6b656e207631"); // 'Session Token v1'

#[cfg(test)]
mod tests {
    use starknet::{
        accounts::{Account, Call, ConnectedAccount},
        core::types::FieldElement,
        macros::selector,
        signers::SigningKey,
    };

    use crate::{
        deploy_contract::single_owner_account,
        tests::{
            deployment_test::create_account,
            runners::{DevnetRunner, TestnetRunner},
        },
    };

    use super::*;

    #[tokio::test]
    async fn test_session() {
        let runner = DevnetRunner::load();
        let prefunded = runner.prefunded_single_owner_account().await;
        let master = create_account(&prefunded).await;

        let session_key = SigningKey::from_random();
        let mut session = SessionSignature::default();
        session.sign(&session_key);

        let to = master.address();
        let session = Session::default();
        let (chain_id, address) = (prefunded.chain_id(), prefunded.address());
        let account = SessionAccount::new(session, master, chain_id, address, session_key);

        println!("selector: {}", selector!("validate_session"));
        println!("address: {}", account.address());

        let calls = vec![Call {
            to,
            selector: selector!("revoke_session"),
            calldata: vec![felt!("0x2137")],
        }];
        account.execute(calls.clone()).send().await.unwrap();
        // account.execute(calls).send().await.unwrap();
    }

    // #[tokio::test]
    // async fn test_validate_session_valid() {
    //     let runner = DevnetRunner::load();
    //     let prefunded = runner.prefunded_single_owner_account().await;
    //     let account = create_account(&prefunded).await;

    //     let session_key = SigningKey::from_random();
    //     let mut session = SessionSignature::default();
    //     session.sign(&session_key);

    //     let call: Vec<FieldElement> = CallSequence::default().into();
    //     let calldata = vec![session.clone().into(), call]
    //         .into_iter()
    //         .flatten()
    //         .collect();

    //     let calls = vec![Call {
    //         to: account.address(),
    //         selector: selector!("validate_session"),
    //         calldata,
    //     }];

    //     // New account for signing, for signing with the session key
    //     let session_account =
    //         single_owner_account(account.provider(), session_key, account.address()).await;

    //     let session_key_signature = session_account
    //         .execute(calls.clone())
    //         .nonce(account.get_nonce().await.unwrap())
    //         .max_fee(FieldElement::MAX)
    //         .prepared()
    //         .unwrap()
    //         .get_invoke_request(false)
    //         .await
    //         .unwrap()
    //         .signature;

    //     assert_eq!(session_key_signature.len(), 2);

    //     // TODO: move signature from parameter as now it's chicken and the egg problem
    //     //       as we need to sign the calldata
    //     // session.r = session_key_signature[0];
    //     // session.s = session_key_signature[1];

    //     // Then the original account has to sign session details, and include them as session_token

    //     account
    //         .execute(calls)
    //         .send()
    //         .await
    //         .expect("Failed to execute");
    // }

    // #[tokio::test]
    // async fn test_validate_session_revoked() {
    //     let runner = DevnetRunner::load();
    //     let prefunded = runner.prefunded_single_owner_account().await;
    //     let account = create_account(&prefunded).await;

    //     account
    //         .execute(vec![Call {
    //             to: account.address(),
    //             selector: selector!("revoke_session"),
    //             calldata: vec![2137u32.into(), u64::MAX.into()],
    //         }])
    //         .send()
    //         .await
    //         .expect("Failed to execute");

    //     let signature: Vec<FieldElement> = SessionSignature::default().into();
    //     let call: Vec<FieldElement> = CallSequence::default().into();

    //     let result = account
    //         .execute(vec![Call {
    //             to: account.address(),
    //             selector: selector!("validate_session"),
    //             calldata: vec![signature, call].into_iter().flatten().collect(),
    //         }])
    //         .send()
    //         .await;

    //     assert!(result.is_err());
    // }
}
