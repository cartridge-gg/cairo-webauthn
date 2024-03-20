use wasm_bindgen_test::*;

// FIXME: Currently wasm tests are failing with error below. 
//
// Error: failed to deserialize wasm module          

// Caused by:
//     0: failed to parse code section
//     1: locals exceed maximum (at offset 738889)
// error: test failed, to rerun pass `--lib`
#[wasm_bindgen_test]
fn pass() {
    assert_eq!(1, 1);
}