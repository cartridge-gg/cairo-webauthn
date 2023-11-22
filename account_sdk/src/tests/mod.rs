mod katana_test;
mod new_deploy_test;
mod one_file_all;

#[macro_export]
macro_rules! field_elem {
    ($a:tt) => {
        starknet::core::types::FieldElement::from_hex_be($a).unwrap()
    };
}
