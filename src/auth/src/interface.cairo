use webauthn_auth::component::{WebauthnPubKey, WebauthnSignature};

#[starknet::interface]
trait IWebauthn<TContractState> {
    fn setWebauthnPubKey (
        ref self: TContractState, 
        public_key: WebauthnPubKey,
    );
    fn getWebauthnPubKey (
        self: @TContractState, 
    ) -> Option<WebauthnPubKey>;
    fn verifyWebauthnSigner(
        self: @TContractState, 
        signature: WebauthnSignature,
        tx_hash: felt252,
    ) -> bool;
    fn verifyWebauthnSignerSerialized(
        self: @TContractState, 
        signature: Span<felt252>,
        tx_hash: felt252,
    ) -> felt252;
}
