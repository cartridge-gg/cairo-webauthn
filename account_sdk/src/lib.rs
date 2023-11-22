pub mod deploy_contract;
mod transaction_waiter;

#[cfg(not(target_arch = "wasm32"))]
pub mod providers;

#[cfg(test)]
mod tests;

use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    pub fn alert(s: &str);
}
