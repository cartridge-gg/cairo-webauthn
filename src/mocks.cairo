use result::ResultTrait;
use core::clone::Clone;
use array::ArrayTrait;
use traits::PartialEq;

use webauthn::webauthn::WebauthnStoreTrait;
use webauthn::types::{
    PublicKeyCredentialDescriptor,
    PublicKey
};
use webauthn::errors::StoreError;
use webauthn::helpers::{
    ContainsTrait,
    PartialEqArray
};

#[derive(Drop, Clone)]
struct DummyRegistration {
    raw_id: Array<u8>,
    public_key: PublicKey
}

#[derive(Drop, Clone)]
struct DummyStore {
    registrations: Array<DummyRegistration>
}

impl ImplDummyStore of WebauthnStoreTrait<DummyStore> {
    fn verify_allow_credentials(
        self: @DummyStore, 
        allow_credentials: @Array<PublicKeyCredentialDescriptor>
    ) -> Result<(), ()>{
        Result::Ok(())
    }
    fn retrieve_public_key(
        self: @DummyStore, 
        credential_raw_id: @Array<u8>
    ) -> Result<PublicKey, StoreError>{
        let la: usize = self.registrations.len();
        let mut i: usize = 0;
        let result = loop {
            if i == la {
                break Result::Err(StoreError::KeyRetirevalFailed);
            }
            let temp = self.registrations.at(i);
            if temp.raw_id == credential_raw_id {
                break Result::Ok(temp.public_key.clone());
            }
            i += 1_usize;
        };
        result
    }
}
