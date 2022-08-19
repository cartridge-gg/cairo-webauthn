
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

    let client_data_json_len = 51
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


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
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
        BigInt3(25760171930652144217185068,32068541556870573761232590,13797202893288408174281844),
        BigInt3(12023251181684780489161710,70247614754882397296496088,2493355613196942977075715),
    )
    let r = BigInt3(75058429540073154809997664,16117088969378175025004874,6794859814446335188227798)
    let s = BigInt3(778027464278423483385406,40663062971808498561013768,17706897557216519140269823)

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

    let client_data_json_len = 38
    let client_data_json_rem = 3
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
    assert client_data_json[19] = 811223361
    assert client_data_json[20] = 1094795585
    assert client_data_json[21] = 573317743
    assert client_data_json[22] = 1919510377
    assert client_data_json[23] = 1847736866
    assert client_data_json[24] = 1752462448
    assert client_data_json[25] = 1933193007
    assert client_data_json[26] = 1668247156
    assert client_data_json[27] = 1919904876
    assert client_data_json[28] = 1701981795
    assert client_data_json[29] = 1634890866
    assert client_data_json[30] = 1768187749
    assert client_data_json[31] = 778528546
    assert client_data_json[32] = 740451186
    assert client_data_json[33] = 1869837135
    assert client_data_json[34] = 1919510377
    assert client_data_json[35] = 1847736934
    assert client_data_json[36] = 1634497381
    assert client_data_json[37] = 2097152000


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
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
func test_signer_1{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(36551267051905699018646970,28498347870562362253846039,17185273288657963468083968),
        BigInt3(71194959876607486613003661,55986233559482261153311711,1277819852157934310649112),
    )
    let r = BigInt3(30005288274251490540322732,75232237571376517256311951,15918505113995799101436148)
    let s = BigInt3(22992447307859184456987328,46642451501936371138254603,1661472446755099220276568)

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

    let client_data_json_len = 30
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
    assert client_data_json[19] = 811223361
    assert client_data_json[20] = 1094795585
    assert client_data_json[21] = 573317743
    assert client_data_json[22] = 1919510377
    assert client_data_json[23] = 1847736866
    assert client_data_json[24] = 1629629474
    assert client_data_json[25] = 1668444019
    assert client_data_json[26] = 1934586473
    assert client_data_json[27] = 1734962722
    assert client_data_json[28] = 979788140
    assert client_data_json[29] = 1936030976


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
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
func test_signer_2{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(74221456455340304468914311,76243887401157693143479692,1737205609488046265298201),
        BigInt3(59954067020306188383223705,61157685282075898430989480,1633860405967725038928253),
    )
    let r = BigInt3(58468766165818579457731141,71632859631983659766292210,16597957639503060857875411)
    let s = BigInt3(36821628610644384771789886,59128503035488810450994937,3649559649222303632123885)

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

    let client_data_json_len = 30
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
    assert client_data_json[19] = 811223361
    assert client_data_json[20] = 1094795585
    assert client_data_json[21] = 573317743
    assert client_data_json[22] = 1919510377
    assert client_data_json[23] = 1847736866
    assert client_data_json[24] = 1633755692
    assert client_data_json[25] = 576942703
    assert client_data_json[26] = 1936936818
    assert client_data_json[27] = 1768384878
    assert client_data_json[28] = 574252641
    assert client_data_json[29] = 1819501949


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
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
func test_signer_3{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(56403849990004304111072824,74362332543896245548958574,14131655404782512978288830),
        BigInt3(23067879079001393540883477,20971221835550589391879441,15125591164054873838597505),
    )
    let r = BigInt3(58257748763284148239062022,33697351232426634997986720,5730017552132388003695179)
    let s = BigInt3(62791671829616950974938253,36404921943391197667108673,17973615942629226038330120)

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

    let client_data_json_len = 31
    let client_data_json_rem = 3
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
    assert client_data_json[19] = 811223361
    assert client_data_json[20] = 1094795585
    assert client_data_json[21] = 573317743
    assert client_data_json[22] = 1919510377
    assert client_data_json[23] = 1847736866
    assert client_data_json[24] = 1633771810
    assert client_data_json[25] = 740451186
    assert client_data_json[26] = 1869837135
    assert client_data_json[27] = 1919510377
    assert client_data_json[28] = 1847736934
    assert client_data_json[29] = 1634497381
    assert client_data_json[30] = 2097152000


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
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
func test_signer_4{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(73151308418410296443681707,4026780844593732239200737,15533482936332148686331247),
        BigInt3(47323179872348418795566782,65084837696000726171930957,7958482415077784898500590),
    )
    let r = BigInt3(51625305160786376153522009,36372896870724203639987059,13630531080504629457046006)
    let s = BigInt3(40289127773377078333942354,56889599624906185296406024,4143335259770152485878839)

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

    let client_data_json_len = 31
    let client_data_json_rem = 2
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
    assert client_data_json[19] = 811223361
    assert client_data_json[20] = 1094795585
    assert client_data_json[21] = 573317743
    assert client_data_json[22] = 1919510377
    assert client_data_json[23] = 1847736866
    assert client_data_json[24] = 1633771873
    assert client_data_json[25] = 573317731
    assert client_data_json[26] = 1919906675
    assert client_data_json[27] = 1332898151
    assert client_data_json[28] = 1768825402
    assert client_data_json[29] = 1717660787
    assert client_data_json[30] = 1702690816


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
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
func test_signer_5{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(25683276147112624207028632,14740352669400185103164493,17647894587026382919523780),
        BigInt3(2172573602643879111421122,65788057709669631640459187,2841294509863129108200854),
    )
    let r = BigInt3(34208144372223917959647955,8235235591399641944995408,17610492983085559455648797)
    let s = BigInt3(57843155227047969778821311,62714608048995079885904650,15032049747010645965550993)

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

    let client_data_json_len = 31
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
    assert client_data_json[19] = 811223361
    assert client_data_json[20] = 1094795585
    assert client_data_json[21] = 573317743
    assert client_data_json[22] = 1919510377
    assert client_data_json[23] = 1847736866
    assert client_data_json[24] = 1633771873
    assert client_data_json[25] = 1629629474
    assert client_data_json[26] = 1668444019
    assert client_data_json[27] = 1934586473
    assert client_data_json[28] = 1734962722
    assert client_data_json[29] = 979788140
    assert client_data_json[30] = 1936030976


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
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
func test_invoke_0{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
    let public_key_pt = EcPoint(
        BigInt3(18429879044278490260098551,56029233481007147284932680,2037976146929856349747775),
        BigInt3(70840069926882074167622098,21864696605377867683594565,6822006481759038492420837),
    )
    let r = BigInt3(2223599465377360746283669,25752496995673689528630163,705762337381700509015780)
    let s = BigInt3(58393142204606773616845190,12894059864184526358390250,19065811591212739232406187)

    let type_offset_len = 2
    let type_offset_rem = 1

    let challenge_offset_len = 9
    let challenge_offset_rem = 0
    let challenge_len = 11
    let challenge_rem = 1
    let (challenge) = alloc()
    assert challenge[0] = 203116
    assert challenge[1] = 3973237
    assert challenge[2] = 7576440
    assert challenge[3] = 4692306
    assert challenge[4] = 11245325
    assert challenge[5] = 4023842
    assert challenge[6] = 7866257
    assert challenge[7] = 5519863
    assert challenge[8] = 10944597
    assert challenge[9] = 6294853
    assert challenge[10] = 47345


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

    let client_data_json_len = 36
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
    assert client_data_json[9] = 1098411123
    assert client_data_json[10] = 1347109425
    assert client_data_json[11] = 1664447540
    assert client_data_json[12] = 1379232851
    assert client_data_json[13] = 1899324238
    assert client_data_json[14] = 1347901801
    assert client_data_json[15] = 1698784594
    assert client_data_json[16] = 1447325235
    assert client_data_json[17] = 1886863958
    assert client_data_json[18] = 1497444678
    assert client_data_json[19] = 1968194850
    assert client_data_json[20] = 740454258
    assert client_data_json[21] = 1768384878
    assert client_data_json[22] = 574235240
    assert client_data_json[23] = 1953788019
    assert client_data_json[24] = 976170851
    assert client_data_json[25] = 1869509746
    assert client_data_json[26] = 1869376613
    assert client_data_json[27] = 1915642721
    assert client_data_json[28] = 1920234089
    assert client_data_json[29] = 1684497710
    assert client_data_json[30] = 1734812204
    assert client_data_json[31] = 576942703
    assert client_data_json[32] = 1936936818
    assert client_data_json[33] = 1768384878
    assert client_data_json[34] = 574252641
    assert client_data_json[35] = 1819501949


    let authenticator_data_len = 10
    let authenticator_data_rem = 3
    let (authenticator_data) = alloc()
    assert authenticator_data[0] = 547978947
    assert authenticator_data[1] = 4176460842
    assert authenticator_data[2] = 3389847498
    assert authenticator_data[3] = 3141667658
    assert authenticator_data[4] = 164671177
    assert authenticator_data[5] = 2421450441
    assert authenticator_data[6] = 2918684036
    assert authenticator_data[7] = 4202036947
    assert authenticator_data[8] = 486539264
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
