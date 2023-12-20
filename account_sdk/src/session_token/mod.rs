mod account;
mod sequence;
mod session;
#[cfg(test)]
mod test_utils;

pub use account::SessionAccount;
pub use sequence::CallSequence;
pub use session::Session;
use starknet::{core::types::FieldElement, macros::felt};

pub const SIGNATURE_TYPE: FieldElement = felt!("0x53657373696f6e20546f6b656e207631"); // 'Session Token v1'

#[cfg(test)]
mod tests {
    use std::time::Duration;

    use cainome::cairo_serde::ContractAddress;
    use starknet::{
        accounts::{Account, ConnectedAccount},
        macros::selector,
        signers::{LocalWallet, SigningKey},
    };
    use tokio::time::sleep;

    use crate::session_token::SessionAccount;
    use crate::tests::{
        deployment_test::create_account,
        runners::{KatanaRunner, TestnetRunner},
    };
    use crate::{
        abigen::{
            self,
            account::{Call, CartridgeAccount},
        },
        session_token::test_utils::create_session_account,
    };

    use super::*;

    #[tokio::test]
    async fn test_session_compute_proof() {
        let runner = KatanaRunner::load();
        let master = create_account(&runner.prefunded_single_owner_account().await).await;

        let address = master.address();
        let account = CartridgeAccount::new(address, &master);

        let cainome_address = cainome::cairo_serde::ContractAddress::from(address);

        let call = abigen::account::Call {
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
        let master = create_account(&runner.prefunded_single_owner_account().await).await;

        let address = master.address();
        let account = CartridgeAccount::new(address, &master);

        let cainome_address = ContractAddress::from(address);

        let call = Call {
            to: cainome_address,
            selector: selector!("revoke_session"),
            calldata: vec![FieldElement::from(0x2137u32)],
        };

        let root = account.compute_root(&call, &vec![]).call().await.unwrap();

        assert_ne!(root, felt!("0x0"));
    }

    #[tokio::test]
    async fn test_session_valid() {
        let runner = KatanaRunner::load();
        let master = create_account(&runner.prefunded_single_owner_account().await).await;

        let session_key = LocalWallet::from(SigningKey::from_random());

        let mut session = Session::default();
        let cainome_address = ContractAddress::from(master.address());
        let permited_calls = vec![Call {
            to: cainome_address,
            selector: selector!("revoke_session"),
            calldata: vec![FieldElement::from(0x2137u32)],
        }];

        session.set_permitted_calls(permited_calls);

        let (chain_id, address) = (master.chain_id(), master.address());
        let provider = *master.provider();
        let account = SessionAccount::new(provider, session_key, &session, address, chain_id);
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
        let session_account =
            create_session_account(&runner.prefunded_single_owner_account().await).await;

        let account = CartridgeAccount::new(session_account.address(), &session_account);

        account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await
            .unwrap();

        sleep(Duration::from_millis(100)).await;

        let result = account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await;

        assert!(result.is_err(), "Session should be revoked");
    }

    #[tokio::test]
    async fn test_session_invalid_proof() {
        let runner = KatanaRunner::load();
        let mut session_account =
            create_session_account(&runner.prefunded_single_owner_account().await).await;

        let cainome_address = ContractAddress::from(session_account.address());
        session_account.session().set_permitted_calls(vec![Call {
            to: cainome_address,
            selector: selector!("validate_session"),
            calldata: vec![FieldElement::from(0x2137u32)],
        }]);

        let account = CartridgeAccount::new(session_account.address(), &session_account);

        let result = account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await;

        assert!(result.is_err(), "Session should be revoked");
    }
}
