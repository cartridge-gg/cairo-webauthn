use starknet::{
    accounts::{Account, ConnectedAccount, SingleOwnerAccount},
    core::types::FieldElement,
    macros::selector,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
    signers::{LocalWallet, SigningKey},
};

use crate::abigen::account::Call;
use crate::session_token::SessionAccount;
use crate::tests::deployment_test::create_account;

use super::Session;

pub async fn create_session_account<'a>(
    from: &SingleOwnerAccount<&'a JsonRpcClient<HttpTransport>, LocalWallet>,
) -> SessionAccount<&'a JsonRpcClient<HttpTransport>, LocalWallet> {
    let (provider, chain_id) = (from.provider(), from.chain_id());

    let master = create_account(from).await;
    let address = master.address();
    let cainome_address = cainome::cairo_serde::ContractAddress::from(address);

    let call = Call {
        to: cainome_address,
        selector: selector!("revoke_session"),
        calldata: vec![FieldElement::from(0x2137u32)],
    };

    let mut session = Session::default();
    let permited_calls = vec![call];
    session.set_permitted_calls(permited_calls);

    let session_key = LocalWallet::from(SigningKey::from_random());

    SessionAccount::new(provider, session_key, &session, address, chain_id)
}
