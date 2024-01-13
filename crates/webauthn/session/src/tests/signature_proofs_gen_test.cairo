// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/session/signature_proofs_test.py for details
use core::traits::Into;
use core::option::OptionTrait;
use core::array::ArrayTrait;
use webauthn_session::signature::ImplSignatureProofs;

#[test]
#[available_gas(300000)]
fn test_signature_proofs_3() {
    let mut proofs: Array<felt252> = ArrayTrait::new();
    proofs.append(0);
    proofs.append(1);
    proofs.append(2);
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 1).unwrap();
        assert(option.len() == 3, 'Wrong length');
        assert(option.at(0).len() == 1, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(2).at(0) == 2, 'Should equal');
        assert(*option.at(2).at(0) == 2, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 2) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 3).unwrap();
        assert(option.len() == 1, 'Wrong length');
        assert(option.at(0).len() == 3, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(0).at(2) == 2, 'Should equal');
    }
}

#[test]
#[available_gas(1200000)]
fn test_signature_proofs_12() {
    let mut proofs: Array<felt252> = ArrayTrait::new();
    proofs.append(0);
    proofs.append(1);
    proofs.append(2);
    proofs.append(3);
    proofs.append(4);
    proofs.append(5);
    proofs.append(6);
    proofs.append(7);
    proofs.append(8);
    proofs.append(9);
    proofs.append(10);
    proofs.append(11);
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 1).unwrap();
        assert(option.len() == 12, 'Wrong length');
        assert(option.at(0).len() == 1, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(11).at(0) == 11, 'Should equal');
        assert(*option.at(11).at(0) == 11, 'Should equal');
    }
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 2).unwrap();
        assert(option.len() == 6, 'Wrong length');
        assert(option.at(0).len() == 2, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(5).at(0) == 10, 'Should equal');
        assert(*option.at(5).at(1) == 11, 'Should equal');
    }
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 3).unwrap();
        assert(option.len() == 4, 'Wrong length');
        assert(option.at(0).len() == 3, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(3).at(0) == 9, 'Should equal');
        assert(*option.at(3).at(2) == 11, 'Should equal');
    }
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 4).unwrap();
        assert(option.len() == 3, 'Wrong length');
        assert(option.at(0).len() == 4, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(2).at(0) == 8, 'Should equal');
        assert(*option.at(2).at(3) == 11, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 5) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 6).unwrap();
        assert(option.len() == 2, 'Wrong length');
        assert(option.at(0).len() == 6, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(1).at(0) == 6, 'Should equal');
        assert(*option.at(1).at(5) == 11, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 7) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 8) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 9) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 10) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 11) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 12).unwrap();
        assert(option.len() == 1, 'Wrong length');
        assert(option.at(0).len() == 12, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(0).at(11) == 11, 'Should equal');
    }
}

#[test]
#[available_gas(10000000)]
fn test_signature_proofs_100() {
    let mut proofs: Array<felt252> = ArrayTrait::new();
    proofs.append(0);
    proofs.append(1);
    proofs.append(2);
    proofs.append(3);
    proofs.append(4);
    proofs.append(5);
    proofs.append(6);
    proofs.append(7);
    proofs.append(8);
    proofs.append(9);
    proofs.append(10);
    proofs.append(11);
    proofs.append(12);
    proofs.append(13);
    proofs.append(14);
    proofs.append(15);
    proofs.append(16);
    proofs.append(17);
    proofs.append(18);
    proofs.append(19);
    proofs.append(20);
    proofs.append(21);
    proofs.append(22);
    proofs.append(23);
    proofs.append(24);
    proofs.append(25);
    proofs.append(26);
    proofs.append(27);
    proofs.append(28);
    proofs.append(29);
    proofs.append(30);
    proofs.append(31);
    proofs.append(32);
    proofs.append(33);
    proofs.append(34);
    proofs.append(35);
    proofs.append(36);
    proofs.append(37);
    proofs.append(38);
    proofs.append(39);
    proofs.append(40);
    proofs.append(41);
    proofs.append(42);
    proofs.append(43);
    proofs.append(44);
    proofs.append(45);
    proofs.append(46);
    proofs.append(47);
    proofs.append(48);
    proofs.append(49);
    proofs.append(50);
    proofs.append(51);
    proofs.append(52);
    proofs.append(53);
    proofs.append(54);
    proofs.append(55);
    proofs.append(56);
    proofs.append(57);
    proofs.append(58);
    proofs.append(59);
    proofs.append(60);
    proofs.append(61);
    proofs.append(62);
    proofs.append(63);
    proofs.append(64);
    proofs.append(65);
    proofs.append(66);
    proofs.append(67);
    proofs.append(68);
    proofs.append(69);
    proofs.append(70);
    proofs.append(71);
    proofs.append(72);
    proofs.append(73);
    proofs.append(74);
    proofs.append(75);
    proofs.append(76);
    proofs.append(77);
    proofs.append(78);
    proofs.append(79);
    proofs.append(80);
    proofs.append(81);
    proofs.append(82);
    proofs.append(83);
    proofs.append(84);
    proofs.append(85);
    proofs.append(86);
    proofs.append(87);
    proofs.append(88);
    proofs.append(89);
    proofs.append(90);
    proofs.append(91);
    proofs.append(92);
    proofs.append(93);
    proofs.append(94);
    proofs.append(95);
    proofs.append(96);
    proofs.append(97);
    proofs.append(98);
    proofs.append(99);
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 1).unwrap();
        assert(option.len() == 100, 'Wrong length');
        assert(option.at(0).len() == 1, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(99).at(0) == 99, 'Should equal');
        assert(*option.at(99).at(0) == 99, 'Should equal');
    }
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 2).unwrap();
        assert(option.len() == 50, 'Wrong length');
        assert(option.at(0).len() == 2, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(49).at(0) == 98, 'Should equal');
        assert(*option.at(49).at(1) == 99, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 3) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 4).unwrap();
        assert(option.len() == 25, 'Wrong length');
        assert(option.at(0).len() == 4, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(24).at(0) == 96, 'Should equal');
        assert(*option.at(24).at(3) == 99, 'Should equal');
    }
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 5).unwrap();
        assert(option.len() == 20, 'Wrong length');
        assert(option.at(0).len() == 5, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(19).at(0) == 95, 'Should equal');
        assert(*option.at(19).at(4) == 99, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 6) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 7) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 8) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 9) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 10).unwrap();
        assert(option.len() == 10, 'Wrong length');
        assert(option.at(0).len() == 10, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(9).at(0) == 90, 'Should equal');
        assert(*option.at(9).at(9) == 99, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 11) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 12) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 13) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 14) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 15) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 16) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 17) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 18) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 19) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 20).unwrap();
        assert(option.len() == 5, 'Wrong length');
        assert(option.at(0).len() == 20, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(4).at(0) == 80, 'Should equal');
        assert(*option.at(4).at(19) == 99, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 21) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 22) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 23) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 24) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 25).unwrap();
        assert(option.len() == 4, 'Wrong length');
        assert(option.at(0).len() == 25, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(3).at(0) == 75, 'Should equal');
        assert(*option.at(3).at(24) == 99, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 26) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 27) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 28) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 29) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 30) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 31) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 32) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 33) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 34) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 35) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 36) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 37) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 38) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 39) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 40) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 41) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 42) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 43) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 44) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 45) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 46) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 47) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 48) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 49) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 50).unwrap();
        assert(option.len() == 2, 'Wrong length');
        assert(option.at(0).len() == 50, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(1).at(0) == 50, 'Should equal');
        assert(*option.at(1).at(49) == 99, 'Should equal');
    }
    match ImplSignatureProofs::try_new(proofs.span(), 51) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 52) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 53) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 54) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 55) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 56) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 57) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 58) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 59) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 60) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 61) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 62) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 63) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 64) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 65) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 66) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 67) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 68) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 69) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 70) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 71) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 72) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 73) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 74) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 75) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 76) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 77) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 78) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 79) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 80) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 81) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 82) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 83) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 84) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 85) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 86) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 87) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 88) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 89) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 90) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 91) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 92) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 93) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 94) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 95) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 96) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 97) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 98) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    match ImplSignatureProofs::try_new(proofs.span(), 99) {
        Option::Some(_) => assert(false, 'Should be None!'),
        Option::None => ()
    };
    {
        let option = ImplSignatureProofs::try_new(proofs.span(), 100).unwrap();
        assert(option.len() == 1, 'Wrong length');
        assert(option.at(0).len() == 100, 'Wrong length');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(0).at(0) == 0, 'Should equal');
        assert(*option.at(0).at(99) == 99, 'Should equal');
    }
}

