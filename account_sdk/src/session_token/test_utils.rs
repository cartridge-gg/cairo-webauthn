use cainome::cairo_serde::ContractAddress;
use starknet::{
    accounts::{Account, ConnectedAccount, SingleOwnerAccount},
    core::types::FieldElement,
    macros::selector,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
    signers::{LocalWallet, Signer, SigningKey},
};

use crate::abigen::account::{Call, CartridgeAccount};
use crate::session_token::SessionAccount;
use crate::tests::deployment_test::create_account;

use super::Session;

pub async fn create_session_account<'a>(
    from: &SingleOwnerAccount<&'a JsonRpcClient<HttpTransport>, LocalWallet>,
) -> (
    SessionAccount<&'a JsonRpcClient<HttpTransport>, LocalWallet>,
    SigningKey,
) {
    let (provider, chain_id) = (*from.provider(), from.chain_id());

    let (master_account, master_key) = create_account(from).await;

    let address = master_account.address();
    let cartridge_account = CartridgeAccount::new(address, &master_account);
    let cainome_address = ContractAddress::from(address);

    let call = Call {
        to: cainome_address,
        selector: selector!("revoke_session"),
        calldata: vec![],
    };
    let permited_calls = vec![call];

    let session_key = LocalWallet::from(SigningKey::from_random());
    let mut session = Session::new(session_key.get_public_key().await.unwrap(), u64::MAX);
    let session_hash = session
        .set_permitted_calls(permited_calls, cartridge_account)
        .await
        .unwrap();

    let session_token = master_key.sign(&session_hash).unwrap();
    session.set_token(session_token);
    let session_account = SessionAccount::new(provider, session_key, session, address, chain_id);

    (session_account, master_key)
}
