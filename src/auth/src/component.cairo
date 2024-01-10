use starknet::account::Call;
use core::serde::Serde;

#[derive(Drop, Serde, starknet::Store)]
struct WebauthnPubKey{
    x: u256,
    y: u256,
}

#[derive(Drop, Serde)]
struct WebauthnSignature {
    signature_type: felt252,
    r: u256, // 'r' part from ecdsa
    s: u256, // 's' part from ecdsa
    type_offset: usize, // offset to 'type' field in json
    challenge_offset: usize, // offset to 'challenge' field in json
    origin_offset: usize, // offset to 'origin' field in json
    client_data_json: Array<u8>, // json with client_data as 1-byte array 
    origin: Array<u8>, //  array origin as 1-byte array
    authenticator_data: Array<u8>
}

// Based on https://github.com/argentlabs/starknet-plugin-account/blob/3c14770c3f7734ef208536d91bbd76af56dc2043/contracts/plugins/SessionKey.cairo
#[starknet::component]
mod webauthn_component {
    use webauthn_auth::interface::IWebauthn;
use core::array::ArrayTrait;
    use core::result::ResultTrait;
    use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
    use starknet::account::Call;
    use ecdsa::check_ecdsa_signature;
    use starknet::secp256r1::{Secp256r1Point, Secp256r1Impl};
    use webauthn_auth::webauthn::verify;
    use super::{WebauthnPubKey, WebauthnSignature};

    #[storage]
    struct Storage {
        public_key: Option<WebauthnPubKey>,
    }

    mod Errors {
        const INVALID_SIGNATURE: felt252 = 'Account: invalid signature';
    }

    #[embeddable_as(Webauthn)]
    impl WebauthnImpl<
        TContractState, +HasComponent<TContractState>
    > of webauthn_auth::interface::IWebauthn<ComponentState<TContractState>> {
        fn set_webauthn_pub_key (
        ref self: ComponentState<TContractState>, 
        public_key: WebauthnPubKey,
        ) {
            self.public_key.write(Option::Some(public_key));
        }
        fn get_webauthn_pub_key (
            self: @ComponentState<TContractState>, 
        ) -> Option<WebauthnPubKey>{
            self.public_key.read()
        }
        fn verify_webauthn_signer(
            self: @ComponentState<TContractState>, 
            signature: WebauthnSignature,
            tx_hash: felt252,
        ) -> bool{
            let pub = match self.get_webauthn_pub_key() {
                Option::Some(pub) => pub,
                Option::None => { return false; }
            };
            let pub_key = match 
                Secp256r1Impl::secp256_ec_new_syscall(pub.x, pub.y){
                    Result::Ok(pub_key) => pub_key,
                    Result::Err(e) => { return false; }
                };
            let pub_key = match pub_key {
                    Option::Some(pub_key) => pub_key,
                    Option::None => { return false; }
                };
            verify(
                pub_key, 
                signature.r, 
                signature.s, 
                signature.type_offset, 
                signature.challenge_offset, 
                signature.origin_offset, 
                signature.client_data_json, 
                tx_hash, 
                signature.origin, 
                signature.authenticator_data
            ).is_ok()
        }
        fn verify_webauthn_signer_serialized(
            self: @ComponentState<TContractState>, 
            signature: Span<felt252>,
            tx_hash: felt252,
        ) -> felt252{
            let mut signature = signature;
            let signature = Serde::<WebauthnSignature>::deserialize(ref signature).unwrap();
            if self.verify_webauthn_signer(signature, tx_hash) {
                starknet::VALIDATED
            } else {
                Errors::INVALID_SIGNATURE
            }
        }
    }
}
