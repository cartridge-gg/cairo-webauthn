use cairo_args_runner::{arg_array, felt_vec, arg_value};
#[test]
fn test_contains_trait() {
    let target = "../../../target/dev/webauthn_auth.sierra.json";
    let function = "test_array_contains";
    let args = vec![
        arg_array![5, 1, 2, 4, 8, 16, 6, 1, 2, 3, 4, 5, 6],
        arg_value!(2),
    ];
    let result = cairo_args_runner::run(target, function, &args).unwrap();
    
    assert_eq!(result.len(), 1);
    assert_eq!(result[0], true.into());
}
