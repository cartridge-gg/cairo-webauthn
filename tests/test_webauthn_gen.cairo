
%lang starknet
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.alloc import alloc

from src.ec import EcPoint
from src.bigint import BigInt3
from src.base64url import Base64URL

from src.webauthn import Webauthn

@external
func test_signer_0{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(18223926959390538469364519,71351305905837236755326709,323710555303411409025249),
        BigInt3(27369707023191034889863320,68422215896305316930976541,17440612663530469968661206),
    )
    let r = BigInt3(516963198193418871498145,73321360372868294935482075,17000881869358282106013126)
    let s = BigInt3(24190310777105317339596127,34944563947460997812961398,11605954954825294522073845)

    let type_offset_len = 2
    let type_offset_rem = 1

    let challenge_offset_len = 9
    let challenge_offset_rem = 0
    let challenge_len = 11
    let challenge_rem = 1
    let (challenge) = alloc()
    assert challenge[0] = 308376
    assert challenge[1] = 8250128
    assert challenge[2] = 4714604
    assert challenge[3] = 10421903
    assert challenge[4] = 14316312
    assert challenge[5] = 1343164
    assert challenge[6] = 14786929
    assert challenge[7] = 3725904
    assert challenge[8] = 8655931
    assert challenge[9] = 2053312
    assert challenge[10] = 53650

    let origin_offset_len = 28
    let origin_offset_rem = 2
    let origin_len = 13
    let (origin) = alloc()
    assert origin[0] = 1752462448
    assert origin[1] = 1933193007
    assert origin[2] = 1668247156
    assert origin[3] = 1919904876
    assert origin[4] = 1701981541
    assert origin[5] = 825454708
    assert origin[6] = 964130678
    assert origin[7] = 779121253
    assert origin[8] = 1986618743
    assert origin[9] = 778264946
    assert origin[10] = 1953655140
    assert origin[11] = 1734684263
    assert origin[12] = 103

    let client_data_json_len = 34
    let client_data_json_rem = 1
    let (client_data_json) = alloc()
    assert client_data_json[0] = 2065855609
    assert client_data_json[1] = 1885676090
    assert client_data_json[2] = 578250082
    assert client_data_json[3] = 1635087464
    assert client_data_json[4] = 1848534885
    assert client_data_json[5] = 1948396578
    assert client_data_json[6] = 1667785068
    assert client_data_json[7] = 1818586727
    assert client_data_json[8] = 1696741922
    assert client_data_json[9] = 1112298329
    assert client_data_json[10] = 1717914961
    assert client_data_json[11] = 1381974643
    assert client_data_json[12] = 1853317456
    assert client_data_json[13] = 846089561
    assert client_data_json[14] = 1179137592
    assert client_data_json[15] = 878790264
    assert client_data_json[16] = 1330540625
    assert client_data_json[17] = 1749176631
    assert client_data_json[18] = 1211192385
    assert client_data_json[19] = 811223330
    assert client_data_json[20] = 740454258
    assert client_data_json[21] = 1768384878
    assert client_data_json[22] = 574235240
    assert client_data_json[23] = 1953788019
    assert client_data_json[24] = 976170851
    assert client_data_json[25] = 1634890866
    assert client_data_json[26] = 1768187749
    assert client_data_json[27] = 778528546
    assert client_data_json[28] = 740451186
    assert client_data_json[29] = 1869837135
    assert client_data_json[30] = 1919510377
    assert client_data_json[31] = 1847736934
    assert client_data_json[32] = 1634497381
    assert client_data_json[33] = 2097152000


    let authenticator_data_len = 10
    let authenticator_data_rem = 1
    let (authenticator_data) = alloc()
    assert authenticator_data[0] = 547978947
    assert authenticator_data[1] = 4176460842
    assert authenticator_data[2] = 3389847498
    assert authenticator_data[3] = 3141667658
    assert authenticator_data[4] = 164671177
    assert authenticator_data[5] = 2421450441
    assert authenticator_data[6] = 2918684036
    assert authenticator_data[7] = 4202036947
    assert authenticator_data[8] = 83886080
    assert authenticator_data[9] = 0


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    )

    return ()
end
