#[cfg(not(target_arch = "wasm32"))]
pub mod katana;

#[cfg(test)]
mod tests;
