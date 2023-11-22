use std::net::TcpListener;

use starknet::{core::types::FieldElement, signers::SigningKey};

mod katana_test;
mod new_deploy_test;
mod one_file_all;
mod simple_deploy_test;

pub fn find_free_port() -> u16 {
    TcpListener::bind("127.0.0.1:0")
        .unwrap()
        .local_addr()
        .unwrap()
        .port()
}

pub fn prefounded_key_and_address() -> (SigningKey, FieldElement) {
    let signing_key = SigningKey::from_secret_scalar(
        FieldElement::from_hex_be("0x1800000000300000180000000000030000000000003006001800006600")
            .unwrap(),
    );
    let address = FieldElement::from_hex_be(
        "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973",
    )
    .unwrap();
    (signing_key, address)
}

pub fn get_key_and_address_devnet() -> (SigningKey, FieldElement) {
    let signing_key = SigningKey::from_secret_scalar(
        FieldElement::from_hex_be("0x71d7bb07b9a64f6f78ac4c816aff4da9").unwrap(),
    );
    let address = FieldElement::from_hex_be(
        "0x64b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691",
    )
    .unwrap();
    (signing_key, address)
}

#[macro_export]
macro_rules! field_elem {
    ($a:tt) => {
        starknet::core::types::FieldElement::from_hex_be($a).unwrap()
    };
}
