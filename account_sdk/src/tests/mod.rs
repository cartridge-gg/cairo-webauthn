use std::net::TcpListener;

mod contract_test;
mod katana_test;

pub fn find_free_port() -> u16 {
    TcpListener::bind("127.0.0.1:0")
        .unwrap()
        .local_addr()
        .unwrap()
        .port()
}

#[macro_export] macro_rules! field_elem {
    ($a:tt) => {
        starknet::core::types::FieldElement::from_hex_be($a).unwrap()
    };
}
