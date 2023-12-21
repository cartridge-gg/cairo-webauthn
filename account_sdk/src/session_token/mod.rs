mod account;
mod sequence;
mod session;
#[cfg(test)]
mod test_utils;

pub use account::SessionAccount;
pub use sequence::CallSequence;
pub use session::Session;
use starknet::{core::types::FieldElement, macros::felt};

pub const SESSION_SIGNATURE_TYPE: FieldElement = felt!("0x53657373696f6e20546f6b656e207631"); // 'Session Token v1'

#[cfg(test)]
mod tests {
    use std::time::Duration;

    use cainome::cairo_serde::ContractAddress;
    use starknet::{
        accounts::{Account, ConnectedAccount},
        macros::selector,
        signers::{LocalWallet, Signer, SigningKey, VerifyingKey},
    };
    use tokio::time::sleep;

    use crate::tests::{
        deployment_test::create_account,
        runners::{KatanaRunner, TestnetRunner},
    };
    use crate::{
        abigen::account::{Call, CartridgeAccount, SessionSignature, SignatureProofs},
        session_token::test_utils::create_session_account,
    };
    use crate::{deploy_contract::single_owner_account, session_token::SessionAccount};

    use super::*;

    #[tokio::test]
    async fn test_session_valid() {
        let runner = KatanaRunner::load();
        let (master_account, master_key) =
            create_account(&runner.prefunded_single_owner_account().await).await;

        let session_key = LocalWallet::from(SigningKey::from_random());

        let mut session = Session::new(session_key.get_public_key().await.unwrap(), u64::MAX);
        let cainome_address = ContractAddress::from(master_account.address());
        let permited_calls = vec![Call {
            to: cainome_address,
            selector: selector!("revoke_session"),
            calldata: vec![FieldElement::from(0x2137u32)],
        }];

        let master_cartridge_account =
            CartridgeAccount::new(master_account.address(), &master_account);
        let session_hash = session
            .set_permitted_calls(permited_calls, master_cartridge_account)
            .await
            .unwrap();

        let session_token = master_key.sign(&session_hash).unwrap();
        session.set_token(session_token);

        let (chain_id, address) = (master_account.chain_id(), master_account.address());
        let provider = *master_account.provider();
        let account = SessionAccount::new(provider, session_key, session, address, chain_id);
        let account = CartridgeAccount::new(address, &account);

        account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await
            .unwrap();
    }

    #[tokio::test]
    async fn test_session_revoked() {
        let runner = KatanaRunner::load();
        let prefunded_account = runner.prefunded_single_owner_account().await;
        let (session_account, master_key) = create_session_account(&prefunded_account).await;

        let account = CartridgeAccount::new(session_account.address(), &session_account);

        let revoked_address = session_account.address();
        account
            .revoke_session(&revoked_address)
            .send()
            .await
            .unwrap();

        sleep(Duration::from_millis(100)).await;

        let result = account.revoke_session(&revoked_address).send().await;

        assert!(result.is_err(), "Session should be revoked");
    }

    #[tokio::test]
    async fn test_session_invalid_proof() {
        let runner: KatanaRunner = KatanaRunner::load();
        let prefunded_account = runner.prefunded_single_owner_account().await;
        let (mut session_account, master_key) = create_session_account(&prefunded_account).await;

        let cainome_address = ContractAddress::from(session_account.address());

        let master_account = single_owner_account(
            session_account.provider(),
            master_key.clone(),
            session_account.address(),
        )
        .await;
        let master_account = CartridgeAccount::new(session_account.address(), &master_account);

        let session = session_account.session();
        let session_hash = session
            .set_permitted_calls(
                vec![Call {
                    to: cainome_address,
                    selector: selector!("validate_session"),
                    calldata: vec![],
                }],
                master_account,
            )
            .await
            .unwrap();

        let session_token = master_key.sign(&session_hash).unwrap();
        session.set_token(session_token);

        let account = CartridgeAccount::new(session_account.address(), &session_account);

        let result = account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await;

        assert!(result.is_err(), "Signature verification should fail");
    }

    #[tokio::test]
    async fn test_session_many_allowed() {
        let runner = KatanaRunner::load();
        let prefunded_account = runner.prefunded_single_owner_account().await;
        let (mut session_account, master_key) = create_session_account(&prefunded_account).await;

        let master_account = single_owner_account(
            session_account.provider(),
            master_key.clone(),
            session_account.address(),
        )
        .await;
        let master_account = CartridgeAccount::new(session_account.address(), &master_account);
        let cainome_address = ContractAddress::from(session_account.address());
        session_account
            .session()
            .set_permitted_calls(
                vec![
                    Call {
                        to: cainome_address,
                        selector: selector!("revoke_session"),
                        calldata: vec![],
                    },
                    Call {
                        to: cainome_address,
                        selector: selector!("validate_session"),
                        calldata: vec![],
                    },
                    Call {
                        to: cainome_address,
                        selector: selector!("compute_root"),
                        calldata: vec![],
                    },
                    Call {
                        to: cainome_address,
                        selector: selector!("not_yet_defined"),
                        calldata: vec![],
                    },
                ],
                master_account,
            )
            .await
            .unwrap();

        let account = CartridgeAccount::new(session_account.address(), &session_account);

        account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await
            .unwrap();
    }

    #[tokio::test]
    async fn test_session_compute_proof() {
        let runner = KatanaRunner::load();
        let (master_account, master_key) =
            create_account(&runner.prefunded_single_owner_account().await).await;

        let address = master_account.address();
        let account = CartridgeAccount::new(address, &master_account);

        let cainome_address = ContractAddress::from(address);

        let call = Call {
            to: cainome_address,
            selector: selector!("revoke_session"),
            calldata: vec![FieldElement::from(0x2137u32)],
        };

        let proof = account.compute_proof(&vec![call], &0).call().await.unwrap();

        assert_eq!(proof, vec![]);
    }

    #[tokio::test]
    async fn test_session_compute_root() {
        let runner = KatanaRunner::load();
        let (master_account, master_key) =
            create_account(&runner.prefunded_single_owner_account().await).await;

        let address = master_account.address();
        let account = CartridgeAccount::new(address, &master_account);

        let cainome_address = ContractAddress::from(address);

        let call = Call {
            to: cainome_address,
            selector: selector!("revoke_session"),
            calldata: vec![FieldElement::from(0x2137u32)],
        };

        let root = account.compute_root(&call, &vec![]).call().await.unwrap();

        assert_ne!(root, felt!("0x0"));
    }
}
