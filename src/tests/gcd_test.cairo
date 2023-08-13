use core::debug::PrintTrait;
use core::option::OptionTrait;
use webauthn::verify::extended_gcd;
use webauthn::verify::find_mod_inv;

#[test]
#[available_gas(20000000000)]
fn test_gcd_basic() {
    let (gcd, _, _) = extended_gcd(2, 2);
    assert(gcd == 2, 'Expected equal!');

    let (gcd, _, _) = extended_gcd(100, 200);
    assert(gcd == 100, 'Expected equal!');

    let (gcd, _, _) = extended_gcd(1234, 5678);
    assert(gcd == 2, 'Expected equal!');

    let (gcd, _, _) = extended_gcd(
        115792089210356248762697446949407573529996955224135760342422259061068512044369, 
        82845566382340822813767408921328436369277471334456847186275564885436721176381
    );
    assert(gcd == 1, 'Expected equal!');
}

#[test]
#[available_gas(20000000000)]
fn test_gcd_coeffs() {
    let (_, u, _) = extended_gcd(
        115792089210356248762697446949407573529996955224135760342422259061068512044369, 
        82845566382340822813767408921328436369277471334456847186275564885436721176381
    );
    assert(u == 1600717663034531832628214947329687306750460581748918793995544380969226006255, 'Expected equal!');
}

#[test]
#[available_gas(20000000000)]
fn test_mod_inverse() {
    assert(9 == find_mod_inv(3, 26).unwrap(), 'Expected equal!');
    assert(994152 == find_mod_inv(19, 1111111).unwrap(), 'Expected equal!');
    assert(
        66839336048254420017492022222828761956339705861086495807414474742568002887400 
        == find_mod_inv(
            123, 
            115792089210356248762697446949407573529996955224135760342422259061068512044369
        ).unwrap(), 
        'Expected equal!'
    );
    assert(
        73585580342603937845643283645812111855493524956010467759706487646892464511934
        == find_mod_inv(
            82845566382340822813767408921328436369277471334456847186275564885436721190900,
            115792089210356248762697446949407573529996955224135760342422259061068512044369
        ).unwrap(), 
        'Expected equal!'
    );
}
