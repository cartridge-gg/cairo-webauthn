use webauthn::fib::fib;

// testing testing functionality
#[test]
#[available_gas(2000000)]
fn sample_test() {
    assert(7 == 7, 'invalid result');
}

// testing testing functionality
#[test]
#[available_gas(2000000)]
fn fib_test() {
    assert(fib(0,1,10) == 55, 'invalid result');
}
