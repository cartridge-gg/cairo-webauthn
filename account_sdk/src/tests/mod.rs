use std::net::TcpListener;

use starknet::{core::types::FieldElement, signers::SigningKey};

mod contract_test;
mod katana_test;
mod new_deploy_test;
mod simple_deploy_test;

pub fn find_free_port() -> u16 {
    TcpListener::bind("127.0.0.1:0")
        .unwrap()
        .local_addr()
        .unwrap()
        .port()
}

pub fn get_key_and_address() -> (SigningKey, FieldElement) {
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

#[macro_export]
macro_rules! field_elem {
    ($a:tt) => {
        starknet::core::types::FieldElement::from_hex_be($a).unwrap()
    };
}
