mod account;
mod sequence;
mod session;

pub use account::SessionAccount;
pub use sequence::CallSequence;
pub use session::Session;
use starknet::{core::types::FieldElement, macros::felt};

pub const SIGNATURE_TYPE: FieldElement = felt!("0x53657373696f6e20546f6b656e207631"); // 'Session Token v1'

#[cfg(test)]
mod tests {
    use std::time::Duration;

    use starknet::{
        accounts::{Account, ConnectedAccount},
        macros::selector,
        signers::{LocalWallet, SigningKey},
    };
    use tokio::time::sleep;

    use crate::abigen::{self, account::CartridgeAccount};
    use crate::tests::{
        deployment_test::create_account,
        runners::{KatanaRunner, TestnetRunner},
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

        let cainome_address = cainome::cairo_serde::ContractAddress::from(address);

        let call = abigen::account::Call {
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

        let session = Session::default();
        let (chain_id, address) = (master.chain_id(), master.address());
        let provider = *master.provider();
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
        let master = create_account(&runner.prefunded_single_owner_account().await).await;

        let session_key = LocalWallet::from(SigningKey::from_random());

        let session = Session::default();
        let (chain_id, address) = (master.chain_id(), master.address());
        let provider = *master.provider();
        let account = SessionAccount::new(provider, session_key, session, address, chain_id);
        let cartridge_account = CartridgeAccount::new(address, &account);

        cartridge_account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await
            .unwrap();

        sleep(Duration::from_millis(100)).await;

        let result = cartridge_account
            .revoke_session(&FieldElement::from(0x2137u32))
            .send()
            .await;

        assert!(result.is_err(), "Session should be revoked");
    }
}
