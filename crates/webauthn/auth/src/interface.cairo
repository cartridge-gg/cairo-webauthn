use webauthn_auth::component::{WebauthnPubKey, WebauthnSignature};

#[starknet::interface]
trait IWebauthn<TContractState> {
    fn set_webauthn_pub_key(ref self: TContractState, public_key: WebauthnPubKey,);
    fn get_webauthn_pub_key(self: @TContractState,) -> Option<WebauthnPubKey>;
    fn verify_webauthn_signer(
        self: @TContractState, signature: WebauthnSignature, tx_hash: felt252,
    ) -> bool;
    fn verify_webauthn_signer_serialized(
        self: @TContractState, signature: Span<felt252>, tx_hash: felt252,
    ) -> felt252;
}
