mod mod_arithmetic_test;
mod verify_ecdsa_test;
mod webauthn_gen_test;

use array::ArrayTrait;

fn assert_equal_arrays(a : Array<u8>, b : Array<u8>) {
    let la : usize = a.len();
    let lb : usize = b.len();
    assert(la == lb, 'different len');
    let mut i : usize = 0;
    loop {
        if i == la {
            break ();
        }
        assert(*a.at(i) == *b.at(i), 'invalid result');
        i += 1_usize;
    }
}

fn get_auth() -> Array<u8> {
    let mut res = ArrayTrait::<u8>::new();
    res.append(0xe3);
    res.append(0xb0);
    res.append(0xc4);
    res.append(0x42);
    res.append(0x98);
    res.append(0xfc);
    res.append(0x1c);
    res.append(0x14);
    res.append(0x9a);
    res.append(0xfb);
    res.append(0xf4);
    res.append(0xc8);
    res.append(0x99);
    res.append(0x6f);
    res.append(0xb9);
    res.append(0x24);
    res.append(0x27);
    res.append(0xae);
    res.append(0x41);
    res.append(0xe4);
    res.append(0x64);
    res.append(0x9b);
    res.append(0x93);
    res.append(0x4c);
    res.append(0xa4);
    res.append(0x95);
    res.append(0x99);
    res.append(0x1b);
    res.append(0x78);
    res.append(0x52);
    res.append(0xb8);
    res.append(0x55);
    res.append(0x05);
    res.append(0x00);
    res.append(0x00);
    res.append(0x00);
    res.append(0x00);
    res
}
