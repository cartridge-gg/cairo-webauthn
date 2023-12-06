pub mod deploy_contract;
mod transaction_waiter;

#[cfg(test)]
mod tests;
pub mod felt_ser;

use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    pub fn alert(s: &str);
}
