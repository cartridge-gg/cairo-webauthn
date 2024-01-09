// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts for Cairo v0.7.0 (account/account.cairo)

mod interface;
mod signature_type;

use starknet::testing;
use starknet::secp256r1::Secp256r1Point;

#[starknet::interface]
trait IPublicKey<TState> {
    fn set_public_key(ref self: TState, new_public_key: felt252);
    fn get_public_key(self: @TState) -> felt252;
}

#[starknet::interface]
trait IPublicKeyCamel<TState> {
    fn setPublicKey(ref self: TState, newPublicKey: felt252);
    fn getPublicKey(self: @TState) -> felt252;
}


#[starknet::contract]
mod Account {
    use core::option::OptionTrait;
    use core::array::SpanTrait;
    use core::to_byte_array::FormatAsByteArray;
    use webauthn_auth::interface::IWebauthn;
    use core::array::ArrayTrait;
    use core::starknet::SyscallResultTrait;
    use core::traits::Into;
    use core::result::ResultTrait;
    use ecdsa::check_ecdsa_signature;
    use openzeppelin::account::interface;
    use openzeppelin::introspection::src5::SRC5 as src5_component;
    use starknet::account::Call;
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::get_tx_info;
    use starknet::secp256r1::{Secp256r1Point, Secp256r1Impl};
    use webauthn_auth::webauthn::verify;
    use webauthn_session::session_component;
    use webauthn_auth::component::{webauthn_component, WebauthnSignature};
    use serde::Serde;
    use super::signature_type::{SignatureType, SignatureTypeImpl};

    const TRANSACTION_VERSION: felt252 = 1;
    // 2**128 + TRANSACTION_VERSION
    const QUERY_VERSION: felt252 = 0x100000000000000000000000000000001;

    component!(path: src5_component, storage: src5, event: SRC5Event);
    #[abi(embed_v0)]
    impl SRC5Impl = src5_component::SRC5Impl<ContractState>;
    #[abi(embed_v0)]
    impl SRC5CamelImpl = src5_component::SRC5CamelImpl<ContractState>;
    impl SRC5InternalImpl = src5_component::InternalImpl<ContractState>;

    component!(path: session_component, storage: session, event: SessionEvent);
    #[abi(embed_v0)]
    impl SessionImpl = session_component::Session<ContractState>;
    #[abi(embed_v0)]
    impl SessionCamelImpl = session_component::SessionCamel<ContractState>;

    component!(path: webauthn_component, storage: webauthn, event: WebauthnEvent);
    #[abi(embed_v0)]
    impl WebauthnImpl = webauthn_component::Webauthn<ContractState>;

    #[storage]
    struct Storage {
        Account_public_key: felt252,
        #[substorage(v0)]
        src5: src5_component::Storage,
        #[substorage(v0)]
        session: session_component::Storage,
        #[substorage(v0)]
        webauthn: webauthn_component::Storage,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        OwnerAdded: OwnerAdded,
        OwnerRemoved: OwnerRemoved,
        SRC5Event: src5_component::Event,
        SessionEvent: session_component::Event,
        WebauthnEvent: webauthn_component::Event,
    }

    #[derive(Drop, starknet::Event)]
    struct OwnerAdded {
        new_owner_guid: felt252
    }

    #[derive(Drop, starknet::Event)]
    struct OwnerRemoved {
        removed_owner_guid: felt252
    }

    mod Errors {
        const INVALID_CALLER: felt252 = 'Account: invalid caller';
        const INVALID_SIGNATURE: felt252 = 'Account: invalid signature';
        const INVALID_TX_VERSION: felt252 = 'Account: invalid tx version';
        const UNAUTHORIZED: felt252 = 'Account: unauthorized';
    }

    #[constructor]
    fn constructor(ref self: ContractState, _public_key: felt252) {
        self.initializer(_public_key);
    }

    //
    // External
    //

    #[external(v0)]
    impl SRC6Impl of interface::ISRC6<ContractState> {
        fn __execute__(self: @ContractState, mut calls: Array<Call>) -> Array<Span<felt252>> {
            // Avoid calls from other contracts
            // https://github.com/OpenZeppelin/cairo-contracts/issues/344
            let sender = get_caller_address();
            assert(sender.is_zero(), Errors::INVALID_CALLER);

            let tx_info = get_tx_info().unbox();
            let version = tx_info.version;
            if version != TRANSACTION_VERSION {
                assert(version == QUERY_VERSION, Errors::INVALID_TX_VERSION);
            }

            _execute_calls(calls)
        }

        fn __validate__(self: @ContractState, mut calls: Array<Call>) -> felt252 {
            self.validate_transaction(calls)
        }

        fn is_valid_signature(
            self: @ContractState, hash: felt252, signature: Array<felt252>
        ) -> felt252 {
            if self._is_valid_ecdsa_signature(hash, signature.span()) {
                starknet::VALIDATED
            } else {
                0
            }
        }
    }

    #[external(v0)]
    impl SRC6CamelOnlyImpl of interface::ISRC6CamelOnly<ContractState> {
        fn isValidSignature(
            self: @ContractState, hash: felt252, signature: Array<felt252>
        ) -> felt252 {
            SRC6Impl::is_valid_signature(self, hash, signature)
        }
    }

    #[external(v0)]
    impl DeclarerImpl of interface::IDeclarer<ContractState> {
        fn __validate_declare__(self: @ContractState, class_hash: felt252) -> felt252 {
            self.validate_ecdsa_transaction()
        }
    }

    #[external(v0)]
    impl PublicKeyImpl of super::IPublicKey<ContractState> {
        fn get_public_key(self: @ContractState) -> felt252 {
            self.Account_public_key.read()
        }

        fn set_public_key(ref self: ContractState, new_public_key: felt252) {
            assert_only_self();
            self.emit(OwnerRemoved { removed_owner_guid: self.Account_public_key.read() });
            self._set_public_key(new_public_key);
        }
    }

    #[external(v0)]
    impl PublicKeyCamelImpl of super::IPublicKeyCamel<ContractState> {
        fn getPublicKey(self: @ContractState) -> felt252 {
            self.Account_public_key.read()
        }

        fn setPublicKey(ref self: ContractState, newPublicKey: felt252) {
            PublicKeyImpl::set_public_key(ref self, newPublicKey);
        }
    }


    #[external(v0)]
    fn __validate_deploy__(
        self: @ContractState,
        class_hash: felt252,
        contract_address_salt: felt252,
        _public_key: felt252
    ) -> felt252 {
        self.validate_ecdsa_transaction()
    }

    //
    // Internal
    //

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn initializer(ref self: ContractState, _public_key: felt252) {
            self.src5.register_interface(interface::ISRC6_ID);
            self._set_public_key(_public_key);
        }

        fn validate_transaction(self: @ContractState, mut calls: Array<Call>) -> felt252 {
            let tx_info = get_tx_info().unbox();
            let tx_hash = tx_info.transaction_hash;
            let mut signature = tx_info.signature;
            if signature.len() == 2_u32 {
                return self.validate_ecdsa_transaction();
            } 
            let signature_type = match SignatureTypeImpl::new(*signature.at(0_u32)) {
                Option::Some(signature_type) => signature_type,
                Option::None(_) => { return Errors::INVALID_SIGNATURE; },
            };
            match signature_type {
                SignatureType::SessionTokenV1 => {
                    SessionImpl::validate_session_serialized(self, self.get_public_key(), signature, calls.span())
                },
                SignatureType::WebauthnV1 => {
                    WebauthnImpl::verifyWebauthnSignerSerialized(self, signature, tx_hash)
                }
            }
        }

        fn validate_ecdsa_transaction(self: @ContractState) -> felt252 {
            let tx_info = get_tx_info().unbox();
            let tx_hash = tx_info.transaction_hash;
            let mut signature = tx_info.signature;
            if self._is_valid_ecdsa_signature(tx_hash, signature) {
                starknet::VALIDATED
            } else {
                Errors::INVALID_SIGNATURE
            }
        }

        fn _set_public_key(ref self: ContractState, new_public_key: felt252) {
            self.Account_public_key.write(new_public_key);
            self.emit(OwnerAdded { new_owner_guid: new_public_key });
        }

        fn _is_valid_ecdsa_signature(
            self: @ContractState, hash: felt252, signature: Span<felt252>
        ) -> bool {
            if signature.len() == 2_u32 {
                check_ecdsa_signature(
                    hash, self.Account_public_key.read(), *signature.at(0_u32), *signature.at(1_u32)
                )
            } else {
                false
            }
        }
    }

    fn assert_only_self() {
        let caller = get_caller_address();
        let self = get_contract_address();
        assert(self == caller, Errors::UNAUTHORIZED);
    }

    fn _execute_calls(mut calls: Array<Call>) -> Array<Span<felt252>> {
        let mut res = ArrayTrait::new();
        loop {
            match calls.pop_front() {
                Option::Some(call) => {
                    let _res = _execute_single_call(call);
                    res.append(_res);
                },
                Option::None(_) => { break (); },
            };
        };
        res
    }

    fn _execute_single_call(call: Call) -> Span<felt252> {
        let Call{to, selector, calldata } = call;
        starknet::call_contract_syscall(to, selector, calldata.span()).unwrap()
    }
}
