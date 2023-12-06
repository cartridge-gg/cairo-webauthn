pub mod deploy_contract;
pub mod webauthn_signer;
mod transaction_waiter;

#[cfg(test)]
mod tests;
pub mod felt_ser;

use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    pub fn alert(s: &str);
}
