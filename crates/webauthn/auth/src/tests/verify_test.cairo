use core::array::ArrayTrait;
use core::clone::Clone;
use webauthn_auth::webauthn::verify;
use webauthn_auth::types::PublicKey;
use webauthn_auth::errors::AuthnErrorIntoFelt252;
use core::option::OptionTrait;
use core::result::ResultTrait;
use starknet::secp256r1::Secp256Trait;
use starknet::secp256r1::Secp256r1Point;

use core::gas;
use core::testing;


#[test]
#[available_gas(20000000000)]
fn test_1() {
    let public_key_pt: Result<Option<Secp256r1Point>> = Secp256Trait::secp256_ec_new_syscall(
        85361148225729824017625108732123897247053575672172763810522989717862412662042,
        34990362585894687818855246831758567645528911684717374214517047635026995605
    );
    let public_key_pt: Secp256r1Point = public_key_pt.unwrap().unwrap();
    let r: u256 = 75529856265189085717597548073817449083775048352765043385708233156408636830191;
    let s: u256 = 82845566382340822813767408921328436369277471334456847186275564885436721176380;

    let type_offset = 9_usize;

    let challenge_offset = 36;
    let challenge = 313206668563552295186480367985497342214500682124781404885018498606844683363;

    let origin_offset = 91;
    let mut origin = ArrayTrait::<u8>::new();
    origin.append(0x68);
    origin.append(0x74);
    origin.append(0x74);
    origin.append(0x70);
    origin.append(0x73);
    origin.append(0x3A);
    origin.append(0x2F);
    origin.append(0x2F);
    origin.append(0x63);
    origin.append(0x6F);
    origin.append(0x6E);
    origin.append(0x74);
    origin.append(0x72);
    origin.append(0x6F);
    origin.append(0x6C);
    origin.append(0x6C);
    origin.append(0x65);
    origin.append(0x72);
    origin.append(0x2D);
    origin.append(0x65);
    origin.append(0x31);
    origin.append(0x33);
    origin.append(0x70);
    origin.append(0x74);
    origin.append(0x39);
    origin.append(0x77);
    origin.append(0x77);
    origin.append(0x76);
    origin.append(0x2E);
    origin.append(0x70);
    origin.append(0x72);
    origin.append(0x65);
    origin.append(0x76);
    origin.append(0x69);
    origin.append(0x65);
    origin.append(0x77);
    origin.append(0x2E);
    origin.append(0x63);
    origin.append(0x61);
    origin.append(0x72);
    origin.append(0x74);
    origin.append(0x72);
    origin.append(0x69);
    origin.append(0x64);
    origin.append(0x67);
    origin.append(0x65);
    origin.append(0x2E);
    origin.append(0x67);
    origin.append(0x67);

    let mut client_data_json = ArrayTrait::<u8>::new();
    client_data_json.append(123);
    client_data_json.append(34);
    client_data_json.append(116);
    client_data_json.append(121);
    client_data_json.append(112);
    client_data_json.append(101);
    client_data_json.append(34);
    client_data_json.append(58);
    client_data_json.append(34);
    client_data_json.append(119);
    client_data_json.append(101);
    client_data_json.append(98);
    client_data_json.append(97);
    client_data_json.append(117);
    client_data_json.append(116);
    client_data_json.append(104);
    client_data_json.append(110);
    client_data_json.append(46);
    client_data_json.append(103);
    client_data_json.append(101);
    client_data_json.append(116);
    client_data_json.append(34);
    client_data_json.append(44);
    client_data_json.append(34);
    client_data_json.append(99);
    client_data_json.append(104);
    client_data_json.append(97);
    client_data_json.append(108);
    client_data_json.append(108);
    client_data_json.append(101);
    client_data_json.append(110);
    client_data_json.append(103);
    client_data_json.append(101);
    client_data_json.append(34);
    client_data_json.append(58);
    client_data_json.append(34);
    client_data_json.append(65);
    client_data_json.append(76);
    client_data_json.append(70);
    client_data_json.append(69);
    client_data_json.append(121);
    client_data_json.append(81);
    client_data_json.append(80);
    client_data_json.append(69);
    client_data_json.append(50);
    client_data_json.append(98);
    client_data_json.append(67);
    client_data_json.append(55);
    client_data_json.append(88);
    client_data_json.append(87);
    client_data_json.append(85);
    client_data_json.append(109);
    client_data_json.append(117);
    client_data_json.append(77);
    client_data_json.append(111);
    client_data_json.append(68);
    client_data_json.append(79);
    client_data_json.append(65);
    client_data_json.append(117);
    client_data_json.append(67);
    client_data_json.append(111);
    client_data_json.append(111);
    client_data_json.append(75);
    client_data_json.append(68);
    client_data_json.append(86);
    client_data_json.append(105);
    client_data_json.append(45);
    client_data_json.append(89);
    client_data_json.append(57);
    client_data_json.append(118);
    client_data_json.append(70);
    client_data_json.append(75);
    client_data_json.append(73);
    client_data_json.append(112);
    client_data_json.append(103);
    client_data_json.append(70);
    client_data_json.append(74);
    client_data_json.append(71);
    client_data_json.append(77);
    client_data_json.append(34);
    client_data_json.append(44);
    client_data_json.append(34);
    client_data_json.append(111);
    client_data_json.append(114);
    client_data_json.append(105);
    client_data_json.append(103);
    client_data_json.append(105);
    client_data_json.append(110);
    client_data_json.append(34);
    client_data_json.append(58);
    client_data_json.append(34);
    client_data_json.append(104);
    client_data_json.append(116);
    client_data_json.append(116);
    client_data_json.append(112);
    client_data_json.append(115);
    client_data_json.append(58);
    client_data_json.append(47);
    client_data_json.append(47);
    client_data_json.append(99);
    client_data_json.append(111);
    client_data_json.append(110);
    client_data_json.append(116);
    client_data_json.append(114);
    client_data_json.append(111);
    client_data_json.append(108);
    client_data_json.append(108);
    client_data_json.append(101);
    client_data_json.append(114);
    client_data_json.append(45);
    client_data_json.append(103);
    client_data_json.append(105);
    client_data_json.append(116);
    client_data_json.append(45);
    client_data_json.append(116);
    client_data_json.append(97);
    client_data_json.append(114);
    client_data_json.append(114);
    client_data_json.append(101);
    client_data_json.append(110);
    client_data_json.append(99);
    client_data_json.append(101);
    client_data_json.append(45);
    client_data_json.append(101);
    client_data_json.append(110);
    client_data_json.append(103);
    client_data_json.append(45);
    client_data_json.append(49);
    client_data_json.append(57);
    client_data_json.append(53);
    client_data_json.append(45);
    client_data_json.append(99);
    client_data_json.append(114);
    client_data_json.append(101);
    client_data_json.append(100);
    client_data_json.append(101);
    client_data_json.append(110);
    client_data_json.append(116);
    client_data_json.append(105);
    client_data_json.append(97);
    client_data_json.append(108);
    client_data_json.append(45);
    client_data_json.append(114);
    client_data_json.append(101);
    client_data_json.append(103);
    client_data_json.append(105);
    client_data_json.append(115);
    client_data_json.append(116);
    client_data_json.append(114);
    client_data_json.append(97);
    client_data_json.append(116);
    client_data_json.append(105);
    client_data_json.append(111);
    client_data_json.append(110);
    client_data_json.append(45);
    client_data_json.append(57);
    client_data_json.append(55);
    client_data_json.append(54);
    client_data_json.append(54);
    client_data_json.append(57);
    client_data_json.append(55);
    client_data_json.append(46);
    client_data_json.append(112);
    client_data_json.append(114);
    client_data_json.append(101);
    client_data_json.append(118);
    client_data_json.append(105);
    client_data_json.append(101);
    client_data_json.append(119);
    client_data_json.append(46);
    client_data_json.append(99);
    client_data_json.append(97);
    client_data_json.append(114);
    client_data_json.append(116);
    client_data_json.append(114);
    client_data_json.append(105);
    client_data_json.append(100);
    client_data_json.append(103);
    client_data_json.append(101);
    client_data_json.append(46);
    client_data_json.append(103);
    client_data_json.append(103);
    client_data_json.append(34);
    client_data_json.append(44);
    client_data_json.append(34);
    client_data_json.append(99);
    client_data_json.append(114);
    client_data_json.append(111);
    client_data_json.append(115);
    client_data_json.append(115);
    client_data_json.append(79);
    client_data_json.append(114);
    client_data_json.append(105);
    client_data_json.append(103);
    client_data_json.append(105);
    client_data_json.append(110);
    client_data_json.append(34);
    client_data_json.append(58);
    client_data_json.append(102);
    client_data_json.append(97);
    client_data_json.append(108);
    client_data_json.append(115);
    client_data_json.append(101);
    client_data_json.append(125);

    let mut authenticator_data = ArrayTrait::<u8>::new();
    authenticator_data.append(32);
    authenticator_data.append(169);
    authenticator_data.append(126);
    authenticator_data.append(195);
    authenticator_data.append(248);
    authenticator_data.append(239);
    authenticator_data.append(188);
    authenticator_data.append(42);
    authenticator_data.append(202);
    authenticator_data.append(12);
    authenticator_data.append(247);
    authenticator_data.append(202);
    authenticator_data.append(187);
    authenticator_data.append(66);
    authenticator_data.append(11);
    authenticator_data.append(74);
    authenticator_data.append(9);
    authenticator_data.append(208);
    authenticator_data.append(174);
    authenticator_data.append(201);
    authenticator_data.append(144);
    authenticator_data.append(84);
    authenticator_data.append(102);
    authenticator_data.append(201);
    authenticator_data.append(173);
    authenticator_data.append(247);
    authenticator_data.append(149);
    authenticator_data.append(132);
    authenticator_data.append(250);
    authenticator_data.append(117);
    authenticator_data.append(254);
    authenticator_data.append(211);
    authenticator_data.append(5);
    authenticator_data.append(0);
    authenticator_data.append(0);
    authenticator_data.append(0);
    authenticator_data.append(0);

    
    let previous = testing::get_available_gas();
    
    let verify_result = verify(
        public_key_pt,
        r,
        s,
        type_offset,
        challenge_offset,
        origin_offset,
        client_data_json,
        challenge,
        origin,
        authenticator_data
    );

    println!("Gas usage of the \"verify\": {}\n", previous - testing::get_available_gas());

    match verify_result {
        Result::Ok => (),
        Result::Err(e) => { assert(false, AuthnErrorIntoFelt252::into(e)) }
    }
}


