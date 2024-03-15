mod ecdsa;
mod webauthn;
mod mod_arithmetic;
mod types;
mod helpers;
mod errors;
mod component;
mod interface;
mod deserializable_endpoints;

#[cfg(test)]
mod tests;

const WEBAUTHN_V1: felt252 = 'Webauthn v1';
