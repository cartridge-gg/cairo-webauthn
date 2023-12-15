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
    use std::time::Duration;

    use starknet::{
        accounts::{Account, Call, ConnectedAccount},
        macros::selector,
        signers::{LocalWallet, Signer, SigningKey},
    };
    use tokio::time::sleep;

    use crate::tests::{
        deployment_test::create_account,
        runners::{DevnetRunner, TestnetRunner},
    };

    use super::*;

    #[tokio::test]
    async fn test_session_valid() {
        let runner = DevnetRunner::load();
        let master = create_account(&runner.prefunded_single_owner_account().await).await;

        let session_key = SigningKey::from_random();
        let ver = session_key.verifying_key();
        let session_key = LocalWallet::from(session_key);
        assert_eq!(
            ver.scalar(),
            session_key.get_public_key().await.unwrap().scalar()
        );

        let session = Session::default();
        let (chain_id, address) = (master.chain_id(), master.address());
        let provider = *master.provider();
        let account = SessionAccount::new(provider, session_key, session, address, chain_id);

        let calls = vec![Call {
            to: address,
            selector: selector!("revoke_session"),
            calldata: vec![felt!("0x2137")],
        }];

        sleep(Duration::from_secs(10)).await;
        account.execute(calls.clone()).send().await.unwrap();
    }
}
