%lang starknet
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.alloc import alloc

from src.ec import EcPoint
from src.bigint import BigInt3

from src.webauthn import Webauthn

@external
func test_prod_1{syscall_ptr: felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(36525844496041675964996035, 10241496462396168495243035, 12073459884027443802026668),
        BigInt3(73415393325312837716378057, 28653761284285941667865366, 16362988822458663408564975),
    );
    let r = BigInt3(
        32431999755275062146615733, 22573101327764450438735544, 4278003118572111742976144
    );
    let s = BigInt3(
        7826281790655337509219295, 34822081882369703804988609, 12541065345092997903368234
    );

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 145365;
    assert challenge[1] = 4044916;
    assert challenge[2] = 282384;
    assert challenge[3] = 10800460;
    assert challenge[4] = 1537399;
    assert challenge[5] = 10619316;
    assert challenge[6] = 2856410;
    assert challenge[7] = 2839033;
    assert challenge[8] = 5179716;
    assert challenge[9] = 455598;
    assert challenge[10] = 8519;

    let origin_offset_len = 28;
    let origin_offset_rem = 2;
    let origin_len = 13;
    let (origin) = alloc();
    assert origin[0] = 1752462448;
    assert origin[1] = 1933193007;
    assert origin[2] = 1668247156;
    assert origin[3] = 1919904876;
    assert origin[4] = 1701981541;
    assert origin[5] = 825454708;
    assert origin[6] = 964130678;
    assert origin[7] = 779121253;
    assert origin[8] = 1986618743;
    assert origin[9] = 778264946;
    assert origin[10] = 1953655140;
    assert origin[11] = 1734684263;
    assert origin[12] = 103;

    let client_data_json_len = 34;
    let client_data_json_rem = 2;
    let (client_data_json) = alloc();
    assert client_data_json[0] = 2065855609;
    assert client_data_json[1] = 1885676090;
    assert client_data_json[2] = 578250082;
    assert client_data_json[3] = 1635087464;
    assert client_data_json[4] = 1848534885;
    assert client_data_json[5] = 1948396578;
    assert client_data_json[6] = 1667785068;
    assert client_data_json[7] = 1818586727;
    assert client_data_json[8] = 1696741922;
    assert client_data_json[9] = 1097492054;
    assert client_data_json[10] = 1348626480;
    assert client_data_json[11] = 1111832657;
    assert client_data_json[12] = 1884107085;
    assert client_data_json[13] = 1177769523;
    assert client_data_json[14] = 1869049136;
    assert client_data_json[15] = 1261787233;
    assert client_data_json[16] = 1261520949;
    assert client_data_json[17] = 1417112645;
    assert client_data_json[18] = 1115049845;
    assert client_data_json[19] = 1230332706;
    assert client_data_json[20] = 740454258;
    assert client_data_json[21] = 1768384878;
    assert client_data_json[22] = 574235240;
    assert client_data_json[23] = 1953787962;
    assert client_data_json[24] = 791637103;
    assert client_data_json[25] = 1667329128;
    assert client_data_json[26] = 1869837370;
    assert client_data_json[27] = 858796081;
    assert client_data_json[28] = 573317731;
    assert client_data_json[29] = 1919906675;
    assert client_data_json[30] = 1332898151;
    assert client_data_json[31] = 1768825402;
    assert client_data_json[32] = 1717660787;
    assert client_data_json[33] = 1702690816;

    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 1234570725;
    assert authenticator_data[1] = 2282654824;
    assert authenticator_data[2] = 1949570831;
    assert authenticator_data[3] = 1685479515;
    assert authenticator_data[4] = 2414128825;
    assert authenticator_data[5] = 2726703815;
    assert authenticator_data[6] = 2573005754;
    assert authenticator_data[7] = 2199754595;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;

    Webauthn.verify(
        public_key_pt,
        r,
        s,
        type_offset_len,
        type_offset_rem,
        challenge_offset_len,
        challenge_offset_rem,
        challenge_len,
        challenge_rem,
        challenge,
        origin_offset_len,
        origin_offset_rem,
        origin_len,
        origin,
        client_data_json_len,
        client_data_json_rem,
        client_data_json,
        authenticator_data_len,
        authenticator_data_rem,
        authenticator_data,
    );

    return ();
}

@external
func test_prod_2{syscall_ptr: felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(45000653924379414565202930, 51812511094343427049224986, 18903611379613879028297546),
        BigInt3(26962128820636107505728448, 54108962260802805464287940, 777853010800331311018185),
    );
    let r = BigInt3(
        5964266859464398743397517, 12194702507511004375206384, 5387619489754847002438114
    );
    let s = BigInt3(
        16734192563664476476006493, 43405918953682274898394526, 6757594313594888140830695
    );

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 495869;
    assert challenge[1] = 15248097;
    assert challenge[2] = 14093894;
    assert challenge[3] = 1082574;
    assert challenge[4] = 7982213;
    assert challenge[5] = 14106593;
    assert challenge[6] = 366682;
    assert challenge[7] = 13347585;
    assert challenge[8] = 5732778;
    assert challenge[9] = 11233517;
    assert challenge[10] = 27577;

    let origin_offset_len = 28;
    let origin_offset_rem = 2;
    let origin_len = 13;
    let (origin) = alloc();
    assert origin[0] = 1752462448;
    assert origin[1] = 1933193007;
    assert origin[2] = 1668247156;
    assert origin[3] = 1919904876;
    assert origin[4] = 1701981541;
    assert origin[5] = 825454708;
    assert origin[6] = 964130678;
    assert origin[7] = 779121253;
    assert origin[8] = 1986618743;
    assert origin[9] = 778264946;
    assert origin[10] = 1953655140;
    assert origin[11] = 1734684263;
    assert origin[12] = 103;

    let client_data_json_len = 34;
    let client_data_json_rem = 2;
    let (client_data_json) = alloc();
    assert client_data_json[0] = 2065855609;
    assert client_data_json[1] = 1885676090;
    assert client_data_json[2] = 578250082;
    assert client_data_json[3] = 1635087464;
    assert client_data_json[4] = 1848534885;
    assert client_data_json[5] = 1948396578;
    assert client_data_json[6] = 1667785068;
    assert client_data_json[7] = 1818586727;
    assert client_data_json[8] = 1696741922;
    assert client_data_json[9] = 1110787129;
    assert client_data_json[10] = 910914152;
    assert client_data_json[11] = 829896007;
    assert client_data_json[12] = 1162433615;
    assert client_data_json[13] = 1701017926;
    assert client_data_json[14] = 830103400;
    assert client_data_json[15] = 1113221217;
    assert client_data_json[16] = 2033611586;
    assert client_data_json[17] = 1446210929;
    assert client_data_json[18] = 1899129460;
    assert client_data_json[19] = 1631021858;
    assert client_data_json[20] = 740454258;
    assert client_data_json[21] = 1768384878;
    assert client_data_json[22] = 574235240;
    assert client_data_json[23] = 1953787962;
    assert client_data_json[24] = 791637103;
    assert client_data_json[25] = 1667329128;
    assert client_data_json[26] = 1869837370;
    assert client_data_json[27] = 858796081;
    assert client_data_json[28] = 573317731;
    assert client_data_json[29] = 1919906675;
    assert client_data_json[30] = 1332898151;
    assert client_data_json[31] = 1768825402;
    assert client_data_json[32] = 1717660787;
    assert client_data_json[33] = 1702690816;

    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 1234570725;
    assert authenticator_data[1] = 2282654824;
    assert authenticator_data[2] = 1949570831;
    assert authenticator_data[3] = 1685479515;
    assert authenticator_data[4] = 2414128825;
    assert authenticator_data[5] = 2726703815;
    assert authenticator_data[6] = 2573005754;
    assert authenticator_data[7] = 2199754595;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;

    Webauthn.verify(
        public_key_pt,
        r,
        s,
        type_offset_len,
        type_offset_rem,
        challenge_offset_len,
        challenge_offset_rem,
        challenge_len,
        challenge_rem,
        challenge,
        origin_offset_len,
        origin_offset_rem,
        origin_len,
        origin,
        client_data_json_len,
        client_data_json_rem,
        client_data_json,
        authenticator_data_len,
        authenticator_data_rem,
        authenticator_data,
    );

    return ();
}
