// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/auth/verify_signature_test.py for details
use core::traits::Into;
use result::ResultTrait;
use core::option::OptionTrait;
use webauthn_auth::ecdsa::{verify_ecdsa, verify_hashed_ecdsa, VerifyEcdsaError};
use webauthn_auth::types::PublicKey;
use webauthn_auth::webauthn::verify_signature;
use webauthn_auth::errors::AuthnErrorIntoFelt252;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1Point;
use starknet::SyscallResultTrait;
use array::ArrayTrait;

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_0() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(239);
	hash.append(154);
	hash.append(119);
	hash.append(180);
	hash.append(115);
	hash.append(70);
	hash.append(207);
	hash.append(76);
	hash.append(241);
	hash.append(100);
	hash.append(113);
	hash.append(244);
	hash.append(118);
	hash.append(192);
	hash.append(2);
	hash.append(50);
	hash.append(30);
	hash.append(41);
	hash.append(140);
	hash.append(80);
	hash.append(107);
	hash.append(87);
	hash.append(147);
	hash.append(152);
	hash.append(189);
	hash.append(84);
	hash.append(224);
	hash.append(131);
	hash.append(152);
	hash.append(14);
	hash.append(248);
	hash.append(250);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(29);
	auth_data.append(155);
	auth_data.append(166);
	auth_data.append(227);
	auth_data.append(103);
	auth_data.append(118);
	auth_data.append(148);
	auth_data.append(222);
	auth_data.append(108);
	auth_data.append(127);
	auth_data.append(109);
	auth_data.append(131);
	auth_data.append(227);
	auth_data.append(15);
	auth_data.append(134);
	auth_data.append(234);
	auth_data.append(105);
	auth_data.append(224);
	auth_data.append(10);
	auth_data.append(163);
	auth_data.append(52);
	auth_data.append(190);
	auth_data.append(116);
	auth_data.append(192);
	auth_data.append(37);
	auth_data.append(151);
	auth_data.append(138);
	auth_data.append(198);
	auth_data.append(247);
	auth_data.append(224);
	auth_data.append(140);
	auth_data.append(240);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(236);
	sig.append(160);
	sig.append(99);
	sig.append(35);
	sig.append(39);
	sig.append(147);
	sig.append(22);
	sig.append(98);
	sig.append(165);
	sig.append(61);
	sig.append(158);
	sig.append(239);
	sig.append(151);
	sig.append(42);
	sig.append(194);
	sig.append(9);
	sig.append(154);
	sig.append(245);
	sig.append(210);
	sig.append(212);
	sig.append(8);
	sig.append(149);
	sig.append(72);
	sig.append(141);
	sig.append(61);
	sig.append(59);
	sig.append(135);
	sig.append(228);
	sig.append(195);
	sig.append(198);
	sig.append(232);
	sig.append(94);
	sig.append(246);
	sig.append(170);
	sig.append(189);
	sig.append(254);
	sig.append(186);
	sig.append(202);
	sig.append(164);
	sig.append(136);
	sig.append(214);
	sig.append(113);
	sig.append(202);
	sig.append(157);
	sig.append(25);
	sig.append(141);
	sig.append(253);
	sig.append(83);
	sig.append(132);
	sig.append(242);
	sig.append(92);
	sig.append(181);
	sig.append(100);
	sig.append(104);
	sig.append(235);
	sig.append(255);
	sig.append(114);
	sig.append(60);
	sig.append(81);
	sig.append(101);
	sig.append(228);
	sig.append(96);
	sig.append(227);
	sig.append(221);
	let pk = PublicKey {
		 x: 18402001900564500889004704668336102227098588485669975709359617526132369465595, 
		 y: 56315231545714385312866284337279074439496847607020809877028943275342675128637
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_1() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(213);
	hash.append(253);
	hash.append(63);
	hash.append(128);
	hash.append(70);
	hash.append(120);
	hash.append(88);
	hash.append(158);
	hash.append(174);
	hash.append(116);
	hash.append(74);
	hash.append(114);
	hash.append(214);
	hash.append(165);
	hash.append(168);
	hash.append(66);
	hash.append(109);
	hash.append(199);
	hash.append(90);
	hash.append(105);
	hash.append(240);
	hash.append(14);
	hash.append(125);
	hash.append(60);
	hash.append(138);
	hash.append(72);
	hash.append(64);
	hash.append(58);
	hash.append(176);
	hash.append(84);
	hash.append(223);
	hash.append(235);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(118);
	auth_data.append(91);
	auth_data.append(180);
	auth_data.append(178);
	auth_data.append(54);
	auth_data.append(58);
	auth_data.append(196);
	auth_data.append(61);
	auth_data.append(15);
	auth_data.append(41);
	auth_data.append(147);
	auth_data.append(51);
	auth_data.append(236);
	auth_data.append(174);
	auth_data.append(21);
	auth_data.append(101);
	auth_data.append(249);
	auth_data.append(172);
	auth_data.append(228);
	auth_data.append(10);
	auth_data.append(110);
	auth_data.append(52);
	auth_data.append(165);
	auth_data.append(52);
	auth_data.append(104);
	auth_data.append(15);
	auth_data.append(244);
	auth_data.append(217);
	auth_data.append(134);
	auth_data.append(168);
	auth_data.append(84);
	auth_data.append(20);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(34);
	sig.append(25);
	sig.append(38);
	sig.append(89);
	sig.append(165);
	sig.append(254);
	sig.append(105);
	sig.append(254);
	sig.append(147);
	sig.append(154);
	sig.append(166);
	sig.append(34);
	sig.append(190);
	sig.append(222);
	sig.append(63);
	sig.append(235);
	sig.append(46);
	sig.append(105);
	sig.append(183);
	sig.append(203);
	sig.append(132);
	sig.append(114);
	sig.append(242);
	sig.append(185);
	sig.append(53);
	sig.append(103);
	sig.append(78);
	sig.append(213);
	sig.append(11);
	sig.append(109);
	sig.append(195);
	sig.append(110);
	sig.append(21);
	sig.append(189);
	sig.append(33);
	sig.append(60);
	sig.append(245);
	sig.append(204);
	sig.append(199);
	sig.append(136);
	sig.append(205);
	sig.append(114);
	sig.append(181);
	sig.append(28);
	sig.append(140);
	sig.append(118);
	sig.append(90);
	sig.append(146);
	sig.append(127);
	sig.append(116);
	sig.append(87);
	sig.append(51);
	sig.append(201);
	sig.append(180);
	sig.append(98);
	sig.append(237);
	sig.append(92);
	sig.append(13);
	sig.append(215);
	sig.append(38);
	sig.append(209);
	sig.append(21);
	sig.append(134);
	sig.append(102);
	let pk = PublicKey {
		 x: 112797896264292481534431361613645043582257874001226283739794718177061038274421, 
		 y: 71254303448759786391236781267253775396313759687154837559045155662916049626819
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_2() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(211);
	hash.append(68);
	hash.append(97);
	hash.append(75);
	hash.append(144);
	hash.append(226);
	hash.append(164);
	hash.append(130);
	hash.append(159);
	hash.append(20);
	hash.append(10);
	hash.append(9);
	hash.append(129);
	hash.append(100);
	hash.append(251);
	hash.append(74);
	hash.append(136);
	hash.append(206);
	hash.append(190);
	hash.append(146);
	hash.append(117);
	hash.append(164);
	hash.append(44);
	hash.append(176);
	hash.append(71);
	hash.append(45);
	hash.append(252);
	hash.append(211);
	hash.append(169);
	hash.append(26);
	hash.append(207);
	hash.append(161);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(30);
	auth_data.append(218);
	auth_data.append(222);
	auth_data.append(95);
	auth_data.append(203);
	auth_data.append(115);
	auth_data.append(145);
	auth_data.append(229);
	auth_data.append(183);
	auth_data.append(108);
	auth_data.append(6);
	auth_data.append(13);
	auth_data.append(160);
	auth_data.append(250);
	auth_data.append(40);
	auth_data.append(68);
	auth_data.append(3);
	auth_data.append(205);
	auth_data.append(154);
	auth_data.append(36);
	auth_data.append(15);
	auth_data.append(129);
	auth_data.append(120);
	auth_data.append(245);
	auth_data.append(145);
	auth_data.append(87);
	auth_data.append(136);
	auth_data.append(7);
	auth_data.append(247);
	auth_data.append(174);
	auth_data.append(132);
	auth_data.append(91);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(107);
	sig.append(23);
	sig.append(100);
	sig.append(46);
	sig.append(68);
	sig.append(91);
	sig.append(152);
	sig.append(43);
	sig.append(4);
	sig.append(60);
	sig.append(35);
	sig.append(244);
	sig.append(82);
	sig.append(245);
	sig.append(49);
	sig.append(242);
	sig.append(243);
	sig.append(197);
	sig.append(78);
	sig.append(138);
	sig.append(10);
	sig.append(213);
	sig.append(212);
	sig.append(11);
	sig.append(68);
	sig.append(44);
	sig.append(107);
	sig.append(161);
	sig.append(14);
	sig.append(6);
	sig.append(243);
	sig.append(155);
	sig.append(20);
	sig.append(11);
	sig.append(81);
	sig.append(188);
	sig.append(82);
	sig.append(2);
	sig.append(20);
	sig.append(38);
	sig.append(251);
	sig.append(87);
	sig.append(15);
	sig.append(130);
	sig.append(119);
	sig.append(241);
	sig.append(141);
	sig.append(41);
	sig.append(220);
	sig.append(104);
	sig.append(64);
	sig.append(186);
	sig.append(140);
	sig.append(127);
	sig.append(254);
	sig.append(61);
	sig.append(238);
	sig.append(114);
	sig.append(136);
	sig.append(46);
	sig.append(102);
	sig.append(166);
	sig.append(121);
	sig.append(37);
	let pk = PublicKey {
		 x: 51433912458511107164458704190198697145314552054458208226930830323647644118402, 
		 y: 112403046405652821248888504113111252163791181090021947887817912033775374958572
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_3() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(25);
	hash.append(59);
	hash.append(103);
	hash.append(164);
	hash.append(218);
	hash.append(33);
	hash.append(223);
	hash.append(167);
	hash.append(153);
	hash.append(187);
	hash.append(94);
	hash.append(235);
	hash.append(246);
	hash.append(253);
	hash.append(11);
	hash.append(164);
	hash.append(124);
	hash.append(17);
	hash.append(229);
	hash.append(119);
	hash.append(120);
	hash.append(211);
	hash.append(213);
	hash.append(48);
	hash.append(227);
	hash.append(132);
	hash.append(123);
	hash.append(105);
	hash.append(68);
	hash.append(90);
	hash.append(220);
	hash.append(91);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(144);
	auth_data.append(245);
	auth_data.append(182);
	auth_data.append(50);
	auth_data.append(226);
	auth_data.append(177);
	auth_data.append(115);
	auth_data.append(221);
	auth_data.append(160);
	auth_data.append(154);
	auth_data.append(221);
	auth_data.append(223);
	auth_data.append(136);
	auth_data.append(126);
	auth_data.append(6);
	auth_data.append(90);
	auth_data.append(69);
	auth_data.append(131);
	auth_data.append(130);
	auth_data.append(132);
	auth_data.append(71);
	auth_data.append(160);
	auth_data.append(54);
	auth_data.append(137);
	auth_data.append(118);
	auth_data.append(44);
	auth_data.append(130);
	auth_data.append(218);
	auth_data.append(222);
	auth_data.append(59);
	auth_data.append(180);
	auth_data.append(41);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(129);
	sig.append(94);
	sig.append(151);
	sig.append(76);
	sig.append(123);
	sig.append(16);
	sig.append(86);
	sig.append(162);
	sig.append(147);
	sig.append(119);
	sig.append(223);
	sig.append(219);
	sig.append(201);
	sig.append(120);
	sig.append(116);
	sig.append(201);
	sig.append(131);
	sig.append(185);
	sig.append(246);
	sig.append(210);
	sig.append(119);
	sig.append(97);
	sig.append(65);
	sig.append(68);
	sig.append(27);
	sig.append(228);
	sig.append(233);
	sig.append(92);
	sig.append(130);
	sig.append(58);
	sig.append(39);
	sig.append(146);
	sig.append(154);
	sig.append(138);
	sig.append(143);
	sig.append(191);
	sig.append(114);
	sig.append(46);
	sig.append(90);
	sig.append(66);
	sig.append(127);
	sig.append(170);
	sig.append(87);
	sig.append(213);
	sig.append(146);
	sig.append(76);
	sig.append(167);
	sig.append(145);
	sig.append(206);
	sig.append(62);
	sig.append(166);
	sig.append(201);
	sig.append(165);
	sig.append(101);
	sig.append(29);
	sig.append(150);
	sig.append(251);
	sig.append(174);
	sig.append(101);
	sig.append(208);
	sig.append(41);
	sig.append(14);
	sig.append(89);
	sig.append(93);
	let pk = PublicKey {
		 x: 26655792660337593206437930429691368551299146009750983293670143519242799702553, 
		 y: 87647649830268020426432082113220492680354126267818401024181802724337495711729
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_4() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(184);
	hash.append(155);
	hash.append(72);
	hash.append(178);
	hash.append(217);
	hash.append(209);
	hash.append(91);
	hash.append(143);
	hash.append(145);
	hash.append(47);
	hash.append(199);
	hash.append(9);
	hash.append(5);
	hash.append(125);
	hash.append(237);
	hash.append(78);
	hash.append(161);
	hash.append(234);
	hash.append(157);
	hash.append(3);
	hash.append(214);
	hash.append(13);
	hash.append(200);
	hash.append(63);
	hash.append(245);
	hash.append(248);
	hash.append(222);
	hash.append(245);
	hash.append(230);
	hash.append(126);
	hash.append(136);
	hash.append(62);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(6);
	auth_data.append(224);
	auth_data.append(187);
	auth_data.append(1);
	auth_data.append(23);
	auth_data.append(229);
	auth_data.append(224);
	auth_data.append(177);
	auth_data.append(59);
	auth_data.append(234);
	auth_data.append(132);
	auth_data.append(48);
	auth_data.append(87);
	auth_data.append(190);
	auth_data.append(94);
	auth_data.append(132);
	auth_data.append(110);
	auth_data.append(183);
	auth_data.append(47);
	auth_data.append(136);
	auth_data.append(218);
	auth_data.append(62);
	auth_data.append(220);
	auth_data.append(228);
	auth_data.append(0);
	auth_data.append(63);
	auth_data.append(60);
	auth_data.append(16);
	auth_data.append(79);
	auth_data.append(6);
	auth_data.append(79);
	auth_data.append(143);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(173);
	sig.append(237);
	sig.append(143);
	sig.append(122);
	sig.append(3);
	sig.append(75);
	sig.append(172);
	sig.append(61);
	sig.append(87);
	sig.append(140);
	sig.append(95);
	sig.append(10);
	sig.append(116);
	sig.append(206);
	sig.append(39);
	sig.append(174);
	sig.append(47);
	sig.append(63);
	sig.append(147);
	sig.append(190);
	sig.append(224);
	sig.append(210);
	sig.append(75);
	sig.append(184);
	sig.append(42);
	sig.append(242);
	sig.append(194);
	sig.append(200);
	sig.append(148);
	sig.append(62);
	sig.append(200);
	sig.append(119);
	sig.append(163);
	sig.append(136);
	sig.append(95);
	sig.append(133);
	sig.append(50);
	sig.append(248);
	sig.append(228);
	sig.append(241);
	sig.append(129);
	sig.append(89);
	sig.append(33);
	sig.append(78);
	sig.append(78);
	sig.append(121);
	sig.append(127);
	sig.append(61);
	sig.append(148);
	sig.append(202);
	sig.append(104);
	sig.append(64);
	sig.append(60);
	sig.append(28);
	sig.append(215);
	sig.append(77);
	sig.append(137);
	sig.append(56);
	sig.append(40);
	sig.append(229);
	sig.append(190);
	sig.append(132);
	sig.append(75);
	sig.append(223);
	let pk = PublicKey {
		 x: 47572600532379441151045920284709874249474522633466997383982335761970678959876, 
		 y: 85305581203708391567186488089708763898401471937002945701110635066199442145291
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_5() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(123);
	hash.append(173);
	hash.append(255);
	hash.append(118);
	hash.append(82);
	hash.append(169);
	hash.append(125);
	hash.append(30);
	hash.append(79);
	hash.append(61);
	hash.append(109);
	hash.append(82);
	hash.append(85);
	hash.append(213);
	hash.append(92);
	hash.append(136);
	hash.append(167);
	hash.append(248);
	hash.append(117);
	hash.append(31);
	hash.append(40);
	hash.append(86);
	hash.append(56);
	hash.append(52);
	hash.append(142);
	hash.append(148);
	hash.append(110);
	hash.append(62);
	hash.append(154);
	hash.append(8);
	hash.append(217);
	hash.append(252);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(245);
	auth_data.append(85);
	auth_data.append(121);
	auth_data.append(79);
	auth_data.append(232);
	auth_data.append(35);
	auth_data.append(240);
	auth_data.append(146);
	auth_data.append(136);
	auth_data.append(158);
	auth_data.append(123);
	auth_data.append(25);
	auth_data.append(176);
	auth_data.append(171);
	auth_data.append(37);
	auth_data.append(187);
	auth_data.append(203);
	auth_data.append(228);
	auth_data.append(202);
	auth_data.append(70);
	auth_data.append(71);
	auth_data.append(139);
	auth_data.append(50);
	auth_data.append(10);
	auth_data.append(28);
	auth_data.append(247);
	auth_data.append(36);
	auth_data.append(44);
	auth_data.append(164);
	auth_data.append(58);
	auth_data.append(128);
	auth_data.append(52);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(161);
	sig.append(170);
	sig.append(135);
	sig.append(198);
	sig.append(123);
	sig.append(226);
	sig.append(89);
	sig.append(194);
	sig.append(104);
	sig.append(118);
	sig.append(99);
	sig.append(87);
	sig.append(19);
	sig.append(71);
	sig.append(122);
	sig.append(120);
	sig.append(215);
	sig.append(191);
	sig.append(105);
	sig.append(49);
	sig.append(42);
	sig.append(109);
	sig.append(27);
	sig.append(171);
	sig.append(46);
	sig.append(57);
	sig.append(130);
	sig.append(206);
	sig.append(130);
	sig.append(131);
	sig.append(248);
	sig.append(140);
	sig.append(182);
	sig.append(101);
	sig.append(227);
	sig.append(20);
	sig.append(90);
	sig.append(3);
	sig.append(136);
	sig.append(149);
	sig.append(211);
	sig.append(110);
	sig.append(202);
	sig.append(192);
	sig.append(157);
	sig.append(119);
	sig.append(224);
	sig.append(55);
	sig.append(96);
	sig.append(12);
	sig.append(194);
	sig.append(78);
	sig.append(123);
	sig.append(164);
	sig.append(197);
	sig.append(195);
	sig.append(29);
	sig.append(201);
	sig.append(255);
	sig.append(194);
	sig.append(116);
	sig.append(45);
	sig.append(85);
	sig.append(58);
	let pk = PublicKey {
		 x: 39578401308924283432437067501887348529389950866763012362525829892470443745454, 
		 y: 78253439005499503492755414344006496144808387110494692382363936679841383828479
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_6() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(144);
	hash.append(104);
	hash.append(226);
	hash.append(101);
	hash.append(169);
	hash.append(19);
	hash.append(138);
	hash.append(13);
	hash.append(213);
	hash.append(38);
	hash.append(50);
	hash.append(24);
	hash.append(11);
	hash.append(66);
	hash.append(73);
	hash.append(141);
	hash.append(197);
	hash.append(139);
	hash.append(250);
	hash.append(49);
	hash.append(38);
	hash.append(201);
	hash.append(196);
	hash.append(95);
	hash.append(166);
	hash.append(203);
	hash.append(39);
	hash.append(251);
	hash.append(117);
	hash.append(36);
	hash.append(8);
	hash.append(44);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(245);
	auth_data.append(173);
	auth_data.append(127);
	auth_data.append(113);
	auth_data.append(162);
	auth_data.append(247);
	auth_data.append(253);
	auth_data.append(82);
	auth_data.append(37);
	auth_data.append(196);
	auth_data.append(123);
	auth_data.append(92);
	auth_data.append(145);
	auth_data.append(124);
	auth_data.append(57);
	auth_data.append(136);
	auth_data.append(20);
	auth_data.append(185);
	auth_data.append(236);
	auth_data.append(203);
	auth_data.append(3);
	auth_data.append(13);
	auth_data.append(222);
	auth_data.append(234);
	auth_data.append(23);
	auth_data.append(234);
	auth_data.append(62);
	auth_data.append(15);
	auth_data.append(136);
	auth_data.append(79);
	auth_data.append(49);
	auth_data.append(162);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(131);
	sig.append(127);
	sig.append(79);
	sig.append(167);
	sig.append(221);
	sig.append(58);
	sig.append(122);
	sig.append(54);
	sig.append(85);
	sig.append(146);
	sig.append(113);
	sig.append(191);
	sig.append(142);
	sig.append(255);
	sig.append(93);
	sig.append(143);
	sig.append(157);
	sig.append(255);
	sig.append(174);
	sig.append(10);
	sig.append(248);
	sig.append(246);
	sig.append(91);
	sig.append(64);
	sig.append(189);
	sig.append(46);
	sig.append(159);
	sig.append(126);
	sig.append(141);
	sig.append(235);
	sig.append(228);
	sig.append(86);
	sig.append(100);
	sig.append(248);
	sig.append(210);
	sig.append(168);
	sig.append(130);
	sig.append(83);
	sig.append(15);
	sig.append(106);
	sig.append(18);
	sig.append(99);
	sig.append(91);
	sig.append(191);
	sig.append(97);
	sig.append(144);
	sig.append(206);
	sig.append(167);
	sig.append(15);
	sig.append(116);
	sig.append(119);
	sig.append(236);
	sig.append(207);
	sig.append(163);
	sig.append(66);
	sig.append(35);
	sig.append(154);
	sig.append(180);
	sig.append(202);
	sig.append(49);
	sig.append(43);
	sig.append(186);
	sig.append(253);
	sig.append(211);
	let pk = PublicKey {
		 x: 67365681697757700628404517949260347494570105912034116860017275083225091294720, 
		 y: 93925313539503161466451469350916731670456653279334430131251267841915015029278
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_7() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(178);
	hash.append(77);
	hash.append(5);
	hash.append(232);
	hash.append(60);
	hash.append(191);
	hash.append(57);
	hash.append(208);
	hash.append(225);
	hash.append(53);
	hash.append(112);
	hash.append(144);
	hash.append(76);
	hash.append(246);
	hash.append(108);
	hash.append(73);
	hash.append(195);
	hash.append(120);
	hash.append(86);
	hash.append(98);
	hash.append(172);
	hash.append(187);
	hash.append(14);
	hash.append(19);
	hash.append(210);
	hash.append(86);
	hash.append(98);
	hash.append(158);
	hash.append(217);
	hash.append(57);
	hash.append(210);
	hash.append(63);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(35);
	auth_data.append(215);
	auth_data.append(144);
	auth_data.append(78);
	auth_data.append(38);
	auth_data.append(83);
	auth_data.append(144);
	auth_data.append(23);
	auth_data.append(153);
	auth_data.append(63);
	auth_data.append(29);
	auth_data.append(88);
	auth_data.append(68);
	auth_data.append(27);
	auth_data.append(145);
	auth_data.append(225);
	auth_data.append(237);
	auth_data.append(187);
	auth_data.append(127);
	auth_data.append(59);
	auth_data.append(70);
	auth_data.append(96);
	auth_data.append(7);
	auth_data.append(218);
	auth_data.append(60);
	auth_data.append(224);
	auth_data.append(93);
	auth_data.append(141);
	auth_data.append(239);
	auth_data.append(24);
	auth_data.append(144);
	auth_data.append(107);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(98);
	sig.append(253);
	sig.append(196);
	sig.append(51);
	sig.append(116);
	sig.append(93);
	sig.append(22);
	sig.append(65);
	sig.append(22);
	sig.append(248);
	sig.append(105);
	sig.append(100);
	sig.append(77);
	sig.append(144);
	sig.append(82);
	sig.append(176);
	sig.append(95);
	sig.append(59);
	sig.append(22);
	sig.append(192);
	sig.append(8);
	sig.append(93);
	sig.append(11);
	sig.append(192);
	sig.append(31);
	sig.append(0);
	sig.append(140);
	sig.append(242);
	sig.append(191);
	sig.append(35);
	sig.append(111);
	sig.append(250);
	sig.append(140);
	sig.append(18);
	sig.append(143);
	sig.append(119);
	sig.append(24);
	sig.append(89);
	sig.append(71);
	sig.append(221);
	sig.append(40);
	sig.append(230);
	sig.append(180);
	sig.append(235);
	sig.append(56);
	sig.append(237);
	sig.append(144);
	sig.append(157);
	sig.append(60);
	sig.append(49);
	sig.append(202);
	sig.append(76);
	sig.append(18);
	sig.append(153);
	sig.append(118);
	sig.append(211);
	sig.append(28);
	sig.append(167);
	sig.append(17);
	sig.append(120);
	sig.append(92);
	sig.append(53);
	sig.append(85);
	sig.append(49);
	let pk = PublicKey {
		 x: 8224356367265768767057607377397261915465988419375715666541799790686347956240, 
		 y: 75033738894578806783998461043031027362697173626033998447728546152702025758148
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_8() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(123);
	hash.append(113);
	hash.append(85);
	hash.append(74);
	hash.append(250);
	hash.append(50);
	hash.append(131);
	hash.append(169);
	hash.append(174);
	hash.append(117);
	hash.append(144);
	hash.append(92);
	hash.append(122);
	hash.append(44);
	hash.append(232);
	hash.append(208);
	hash.append(195);
	hash.append(163);
	hash.append(222);
	hash.append(49);
	hash.append(207);
	hash.append(117);
	hash.append(42);
	hash.append(164);
	hash.append(197);
	hash.append(157);
	hash.append(210);
	hash.append(82);
	hash.append(145);
	hash.append(57);
	hash.append(32);
	hash.append(16);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(38);
	auth_data.append(161);
	auth_data.append(98);
	auth_data.append(218);
	auth_data.append(33);
	auth_data.append(80);
	auth_data.append(155);
	auth_data.append(114);
	auth_data.append(226);
	auth_data.append(239);
	auth_data.append(177);
	auth_data.append(121);
	auth_data.append(233);
	auth_data.append(157);
	auth_data.append(53);
	auth_data.append(132);
	auth_data.append(227);
	auth_data.append(133);
	auth_data.append(206);
	auth_data.append(104);
	auth_data.append(169);
	auth_data.append(25);
	auth_data.append(95);
	auth_data.append(77);
	auth_data.append(14);
	auth_data.append(255);
	auth_data.append(120);
	auth_data.append(7);
	auth_data.append(9);
	auth_data.append(9);
	auth_data.append(40);
	auth_data.append(59);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(174);
	sig.append(85);
	sig.append(195);
	sig.append(18);
	sig.append(100);
	sig.append(238);
	sig.append(97);
	sig.append(64);
	sig.append(7);
	sig.append(157);
	sig.append(90);
	sig.append(201);
	sig.append(106);
	sig.append(70);
	sig.append(87);
	sig.append(18);
	sig.append(127);
	sig.append(130);
	sig.append(86);
	sig.append(28);
	sig.append(174);
	sig.append(196);
	sig.append(52);
	sig.append(143);
	sig.append(242);
	sig.append(141);
	sig.append(248);
	sig.append(77);
	sig.append(123);
	sig.append(190);
	sig.append(194);
	sig.append(107);
	sig.append(228);
	sig.append(28);
	sig.append(164);
	sig.append(52);
	sig.append(6);
	sig.append(100);
	sig.append(134);
	sig.append(40);
	sig.append(23);
	sig.append(43);
	sig.append(116);
	sig.append(249);
	sig.append(205);
	sig.append(191);
	sig.append(98);
	sig.append(227);
	sig.append(148);
	sig.append(176);
	sig.append(7);
	sig.append(187);
	sig.append(0);
	sig.append(144);
	sig.append(183);
	sig.append(207);
	sig.append(238);
	sig.append(115);
	sig.append(67);
	sig.append(92);
	sig.append(20);
	sig.append(255);
	sig.append(152);
	sig.append(125);
	let pk = PublicKey {
		 x: 9982668974529383302778758602941864963283087685644977679397133457725659362678, 
		 y: 114869384173757787338829461233949046798368628089022310000877937680719146988237
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_9() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(45);
	hash.append(137);
	hash.append(242);
	hash.append(63);
	hash.append(129);
	hash.append(155);
	hash.append(19);
	hash.append(219);
	hash.append(172);
	hash.append(203);
	hash.append(176);
	hash.append(90);
	hash.append(86);
	hash.append(6);
	hash.append(73);
	hash.append(120);
	hash.append(217);
	hash.append(110);
	hash.append(110);
	hash.append(216);
	hash.append(26);
	hash.append(224);
	hash.append(240);
	hash.append(179);
	hash.append(94);
	hash.append(167);
	hash.append(170);
	hash.append(200);
	hash.append(180);
	hash.append(101);
	hash.append(197);
	hash.append(187);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(128);
	auth_data.append(76);
	auth_data.append(153);
	auth_data.append(178);
	auth_data.append(42);
	auth_data.append(71);
	auth_data.append(23);
	auth_data.append(25);
	auth_data.append(182);
	auth_data.append(208);
	auth_data.append(198);
	auth_data.append(136);
	auth_data.append(248);
	auth_data.append(119);
	auth_data.append(113);
	auth_data.append(158);
	auth_data.append(107);
	auth_data.append(136);
	auth_data.append(31);
	auth_data.append(158);
	auth_data.append(229);
	auth_data.append(161);
	auth_data.append(214);
	auth_data.append(244);
	auth_data.append(166);
	auth_data.append(84);
	auth_data.append(231);
	auth_data.append(175);
	auth_data.append(69);
	auth_data.append(178);
	auth_data.append(212);
	auth_data.append(111);
	auth_data.append(160);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(0);
	auth_data.append(1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(157);
	sig.append(38);
	sig.append(66);
	sig.append(221);
	sig.append(15);
	sig.append(100);
	sig.append(35);
	sig.append(159);
	sig.append(48);
	sig.append(208);
	sig.append(236);
	sig.append(166);
	sig.append(237);
	sig.append(159);
	sig.append(196);
	sig.append(189);
	sig.append(180);
	sig.append(97);
	sig.append(168);
	sig.append(48);
	sig.append(145);
	sig.append(97);
	sig.append(163);
	sig.append(233);
	sig.append(225);
	sig.append(4);
	sig.append(195);
	sig.append(165);
	sig.append(15);
	sig.append(29);
	sig.append(84);
	sig.append(151);
	sig.append(77);
	sig.append(97);
	sig.append(74);
	sig.append(2);
	sig.append(61);
	sig.append(4);
	sig.append(150);
	sig.append(222);
	sig.append(128);
	sig.append(117);
	sig.append(140);
	sig.append(151);
	sig.append(235);
	sig.append(181);
	sig.append(18);
	sig.append(58);
	sig.append(34);
	sig.append(166);
	sig.append(206);
	sig.append(174);
	sig.append(81);
	sig.append(101);
	sig.append(251);
	sig.append(86);
	sig.append(192);
	sig.append(127);
	sig.append(33);
	sig.append(223);
	sig.append(123);
	sig.append(95);
	sig.append(92);
	sig.append(42);
	let pk = PublicKey {
		 x: 39174334694137262116319847864691620993131612292957985065736629505783469788732, 
		 y: 86528844267632478584308498647954992010741347159791994455419023713380217581025
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

