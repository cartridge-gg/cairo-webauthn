
%lang starknet
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.alloc import alloc

from src.ec import EcPoint
from src.bigint import BigInt3

from src.webauthn import Webauthn

@external
func test_0{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(68771434430694404260836634,66633780841359531151283366,14259391536917482115299254),
        BigInt3(15143078500912722485799317,6719228382483657703164717,5845062894556851529125),
    )
    let r = BigInt3(63555563315794279560344047,13095470977131083448599430,12617095898995832105276919)
    let s = BigInt3(51677855527563245207068476,53594536522197615937402726,13839169138395057433218690)

    let type_offset_len = 2
    let type_offset_rem = 1

    let challenge_offset_len = 9
    let challenge_offset_rem = 0
    let challenge_len = 11
    let challenge_rem = 1
    let (challenge) = alloc()
    assert challenge[0] = 45380
    assert challenge[1] = 13173700
    assert challenge[2] = 14266555
    assert challenge[3] = 6120742
    assert challenge[4] = 12110339
    assert challenge[5] = 3672962
    assert challenge[6] = 10650243
    assert challenge[7] = 5648280
    assert challenge[8] = 16183626
    assert challenge[9] = 2267141
    assert challenge[10] = 9315


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

    let client_data_json_len = 52
    let client_data_json_rem = 0
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
    assert client_data_json[9] = 1095517765
    assert client_data_json[10] = 2035372101
    assert client_data_json[11] = 845300535
    assert client_data_json[12] = 1482118509
    assert client_data_json[13] = 1968009028
    assert client_data_json[14] = 1329689923
    assert client_data_json[15] = 1869564740
    assert client_data_json[16] = 1449733465
    assert client_data_json[17] = 964052555
    assert client_data_json[18] = 1232103238
    assert client_data_json[19] = 1246186786
    assert client_data_json[20] = 740454258
    assert client_data_json[21] = 1768384878
    assert client_data_json[22] = 574235240
    assert client_data_json[23] = 1953788019
    assert client_data_json[24] = 976170851
    assert client_data_json[25] = 1869509746
    assert client_data_json[26] = 1869376613
    assert client_data_json[27] = 1915578217
    assert client_data_json[28] = 1949135969
    assert client_data_json[29] = 1920099694
    assert client_data_json[30] = 1667575141
    assert client_data_json[31] = 1852255537
    assert client_data_json[32] = 959786339
    assert client_data_json[33] = 1919247461
    assert client_data_json[34] = 1853122913
    assert client_data_json[35] = 1814917733
    assert client_data_json[36] = 1734964084
    assert client_data_json[37] = 1918989417
    assert client_data_json[38] = 1869491513
    assert client_data_json[39] = 926299705
    assert client_data_json[40] = 925790322
    assert client_data_json[41] = 1702259045
    assert client_data_json[42] = 1999528801
    assert client_data_json[43] = 1920234089
    assert client_data_json[44] = 1684497710
    assert client_data_json[45] = 1734812204
    assert client_data_json[46] = 576942703
    assert client_data_json[47] = 1936936818
    assert client_data_json[48] = 1768384878
    assert client_data_json[49] = 574252641
    assert client_data_json[50] = 1819501949
    assert client_data_json[51] = 0


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

@external
func test_signer_0{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(49648873250394239090517175,48588715481435655243991845,15920036588382874168580923),
        BigInt3(25434387169961794625943231,51697632453011808154963785,10695053385537025959283390),
    )
    let r = BigInt3(46455413659424714676941187,1595626455925220797686163,9255185877509192913959556)
    let s = BigInt3(40183579798431479526707109,50354936914015246562564306,12750035884088465467998605)

    let type_offset_len = 2
    let type_offset_rem = 1

    let challenge_offset_len = 9
    let challenge_offset_rem = 0
    let challenge_len = 11
    let challenge_rem = 2
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
