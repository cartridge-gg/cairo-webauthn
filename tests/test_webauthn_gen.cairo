
%lang starknet
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.alloc import alloc

from src.ec import EcPoint
from src.bigint import BigInt3

from src.webauthn import Webauthn

@external
func test_0{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(68771434430694404260836634,66633780841359531151283366,14259391536917482115299254),
        BigInt3(15143078500912722485799317,6719228382483657703164717,5845062894556851529125),
    );
    let r = BigInt3(63555563315794279560344047,13095470977131083448599430,12617095898995832105276919);
    let s = BigInt3(51677855527563245207068476,53594536522197615937402726,13839169138395057433218690);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 45380;
    assert challenge[1] = 13173700;
    assert challenge[2] = 14266555;
    assert challenge[3] = 6120742;
    assert challenge[4] = 12110339;
    assert challenge[5] = 3672962;
    assert challenge[6] = 10650243;
    assert challenge[7] = 5648280;
    assert challenge[8] = 16183626;
    assert challenge[9] = 2267141;
    assert challenge[10] = 9315;


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

    let client_data_json_len = 51;
    let client_data_json_rem = 0;
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
    assert client_data_json[9] = 1095517765;
    assert client_data_json[10] = 2035372101;
    assert client_data_json[11] = 845300535;
    assert client_data_json[12] = 1482118509;
    assert client_data_json[13] = 1968009028;
    assert client_data_json[14] = 1329689923;
    assert client_data_json[15] = 1869564740;
    assert client_data_json[16] = 1449733465;
    assert client_data_json[17] = 964052555;
    assert client_data_json[18] = 1232103238;
    assert client_data_json[19] = 1246186786;
    assert client_data_json[20] = 740454258;
    assert client_data_json[21] = 1768384878;
    assert client_data_json[22] = 574235240;
    assert client_data_json[23] = 1953788019;
    assert client_data_json[24] = 976170851;
    assert client_data_json[25] = 1869509746;
    assert client_data_json[26] = 1869376613;
    assert client_data_json[27] = 1915578217;
    assert client_data_json[28] = 1949135969;
    assert client_data_json[29] = 1920099694;
    assert client_data_json[30] = 1667575141;
    assert client_data_json[31] = 1852255537;
    assert client_data_json[32] = 959786339;
    assert client_data_json[33] = 1919247461;
    assert client_data_json[34] = 1853122913;
    assert client_data_json[35] = 1814917733;
    assert client_data_json[36] = 1734964084;
    assert client_data_json[37] = 1918989417;
    assert client_data_json[38] = 1869491513;
    assert client_data_json[39] = 926299705;
    assert client_data_json[40] = 925790322;
    assert client_data_json[41] = 1702259045;
    assert client_data_json[42] = 1999528801;
    assert client_data_json[43] = 1920234089;
    assert client_data_json[44] = 1684497710;
    assert client_data_json[45] = 1734812204;
    assert client_data_json[46] = 576942703;
    assert client_data_json[47] = 1936936818;
    assert client_data_json[48] = 1768384878;
    assert client_data_json[49] = 574252641;
    assert client_data_json[50] = 1819501949;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}

@external
func test_signer_0{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(25012752436441115105478499,49124124378805125750268719,5135324779956089724268905),
        BigInt3(30076439151137788477390432,64305721886035337334904854,13358739848599777779525208),
    );
    let r = BigInt3(13519050929327361622390891,46009319887487158475017241,6369176689454961212384116);
    let s = BigInt3(47558491905712022979728254,43633185616126321104281705,3979852399736810048845255);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 408217;
    assert challenge[1] = 10299169;
    assert challenge[2] = 5755576;
    assert challenge[3] = 11627221;
    assert challenge[4] = 8924337;
    assert challenge[5] = 648760;
    assert challenge[6] = 10369204;
    assert challenge[7] = 10869868;
    assert challenge[8] = 6934518;
    assert challenge[9] = 16061922;
    assert challenge[10] = 7711;


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

    let client_data_json_len = 38;
    let client_data_json_rem = 3;
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
    assert client_data_json[9] = 1114272090;
    assert client_data_json[10] = 1850958696;
    assert client_data_json[11] = 1446595380;
    assert client_data_json[12] = 1935110742;
    assert client_data_json[13] = 1766029688;
    assert client_data_json[14] = 1130715444;
    assert client_data_json[15] = 1852467504;
    assert client_data_json[16] = 1885632627;
    assert client_data_json[17] = 1633902386;
    assert client_data_json[18] = 961697897;
    assert client_data_json[19] = 1214789697;
    assert client_data_json[20] = 1094795585;
    assert client_data_json[21] = 573317743;
    assert client_data_json[22] = 1919510377;
    assert client_data_json[23] = 1847736866;
    assert client_data_json[24] = 1752462448;
    assert client_data_json[25] = 1933193007;
    assert client_data_json[26] = 1668247156;
    assert client_data_json[27] = 1919904876;
    assert client_data_json[28] = 1701981795;
    assert client_data_json[29] = 1634890866;
    assert client_data_json[30] = 1768187749;
    assert client_data_json[31] = 778528546;
    assert client_data_json[32] = 740451186;
    assert client_data_json[33] = 1869837135;
    assert client_data_json[34] = 1919510377;
    assert client_data_json[35] = 1847736934;
    assert client_data_json[36] = 1634497381;
    assert client_data_json[37] = 2097152000;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}

@external
func test_signer_1{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(74008420287490269973695952,69596811224342283934917154,6880738978779621517917106),
        BigInt3(61180058060495205121751286,57130280693735662652504978,17047533010952980511229966),
    );
    let r = BigInt3(74311940929082661625824445,14425671446953098605849986,5671486697498487142449318);
    let s = BigInt3(51138854942948771027198350,70500805923408752316884275,9296185290945178587295779);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 408217;
    assert challenge[1] = 10299169;
    assert challenge[2] = 5755576;
    assert challenge[3] = 11627221;
    assert challenge[4] = 8924337;
    assert challenge[5] = 648760;
    assert challenge[6] = 10369204;
    assert challenge[7] = 10869868;
    assert challenge[8] = 6934518;
    assert challenge[9] = 16061922;
    assert challenge[10] = 7711;


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

    let client_data_json_len = 30;
    let client_data_json_rem = 1;
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
    assert client_data_json[9] = 1114272090;
    assert client_data_json[10] = 1850958696;
    assert client_data_json[11] = 1446595380;
    assert client_data_json[12] = 1935110742;
    assert client_data_json[13] = 1766029688;
    assert client_data_json[14] = 1130715444;
    assert client_data_json[15] = 1852467504;
    assert client_data_json[16] = 1885632627;
    assert client_data_json[17] = 1633902386;
    assert client_data_json[18] = 961697897;
    assert client_data_json[19] = 1214789697;
    assert client_data_json[20] = 1094795585;
    assert client_data_json[21] = 573317743;
    assert client_data_json[22] = 1919510377;
    assert client_data_json[23] = 1847736866;
    assert client_data_json[24] = 1629629474;
    assert client_data_json[25] = 1668444019;
    assert client_data_json[26] = 1934586473;
    assert client_data_json[27] = 1734962722;
    assert client_data_json[28] = 979788140;
    assert client_data_json[29] = 1936030976;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}

@external
func test_signer_2{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(295836725683628380410594,10141506841375708210940384,10848579052503748245865010),
        BigInt3(38300071478067146902748441,59677079152624038680554339,7066108923619905425936442),
    );
    let r = BigInt3(69993467096008535915811219,46155820988214537674178233,4653774339050625947048036);
    let s = BigInt3(12477040337686037287454384,24271108472674503260330493,866092695564587603094513);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 408217;
    assert challenge[1] = 10299169;
    assert challenge[2] = 5755576;
    assert challenge[3] = 11627221;
    assert challenge[4] = 8924337;
    assert challenge[5] = 648760;
    assert challenge[6] = 10369204;
    assert challenge[7] = 10869868;
    assert challenge[8] = 6934518;
    assert challenge[9] = 16061922;
    assert challenge[10] = 7711;


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

    let client_data_json_len = 30;
    let client_data_json_rem = 0;
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
    assert client_data_json[9] = 1114272090;
    assert client_data_json[10] = 1850958696;
    assert client_data_json[11] = 1446595380;
    assert client_data_json[12] = 1935110742;
    assert client_data_json[13] = 1766029688;
    assert client_data_json[14] = 1130715444;
    assert client_data_json[15] = 1852467504;
    assert client_data_json[16] = 1885632627;
    assert client_data_json[17] = 1633902386;
    assert client_data_json[18] = 961697897;
    assert client_data_json[19] = 1214789697;
    assert client_data_json[20] = 1094795585;
    assert client_data_json[21] = 573317743;
    assert client_data_json[22] = 1919510377;
    assert client_data_json[23] = 1847736866;
    assert client_data_json[24] = 1633755692;
    assert client_data_json[25] = 576942703;
    assert client_data_json[26] = 1936936818;
    assert client_data_json[27] = 1768384878;
    assert client_data_json[28] = 574252641;
    assert client_data_json[29] = 1819501949;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}

@external
func test_signer_3{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(7809580098988105499883009,63805916707544711087471639,11650147277277846578541959),
        BigInt3(46906755652529858019579995,67775866544992805070903831,12145009258358054763018593),
    );
    let r = BigInt3(6101344783415369747085871,76672342793799188531236163,1714649115976478921442457);
    let s = BigInt3(72103187295440827555022801,30610168348889020412678765,4882800483465824039428906);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 408217;
    assert challenge[1] = 10299169;
    assert challenge[2] = 5755576;
    assert challenge[3] = 11627221;
    assert challenge[4] = 8924337;
    assert challenge[5] = 648760;
    assert challenge[6] = 10369204;
    assert challenge[7] = 10869868;
    assert challenge[8] = 6934518;
    assert challenge[9] = 16061922;
    assert challenge[10] = 7711;


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

    let client_data_json_len = 31;
    let client_data_json_rem = 3;
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
    assert client_data_json[9] = 1114272090;
    assert client_data_json[10] = 1850958696;
    assert client_data_json[11] = 1446595380;
    assert client_data_json[12] = 1935110742;
    assert client_data_json[13] = 1766029688;
    assert client_data_json[14] = 1130715444;
    assert client_data_json[15] = 1852467504;
    assert client_data_json[16] = 1885632627;
    assert client_data_json[17] = 1633902386;
    assert client_data_json[18] = 961697897;
    assert client_data_json[19] = 1214789697;
    assert client_data_json[20] = 1094795585;
    assert client_data_json[21] = 573317743;
    assert client_data_json[22] = 1919510377;
    assert client_data_json[23] = 1847736866;
    assert client_data_json[24] = 1633771810;
    assert client_data_json[25] = 740451186;
    assert client_data_json[26] = 1869837135;
    assert client_data_json[27] = 1919510377;
    assert client_data_json[28] = 1847736934;
    assert client_data_json[29] = 1634497381;
    assert client_data_json[30] = 2097152000;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}

@external
func test_signer_4{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(36676515121821640394681515,45892728070133938449630438,1237900174564046800547172),
        BigInt3(762608308731299248742716,51525479024707853009168561,308616411423965500375862),
    );
    let r = BigInt3(37912955325190875284445090,59032440523663722742133294,5672010022783318891464454);
    let s = BigInt3(3282665679438232385320569,56129081917896712085739136,3107619281104091344758484);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 408217;
    assert challenge[1] = 10299169;
    assert challenge[2] = 5755576;
    assert challenge[3] = 11627221;
    assert challenge[4] = 8924337;
    assert challenge[5] = 648760;
    assert challenge[6] = 10369204;
    assert challenge[7] = 10869868;
    assert challenge[8] = 6934518;
    assert challenge[9] = 16061922;
    assert challenge[10] = 7711;


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

    let client_data_json_len = 31;
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
    assert client_data_json[9] = 1114272090;
    assert client_data_json[10] = 1850958696;
    assert client_data_json[11] = 1446595380;
    assert client_data_json[12] = 1935110742;
    assert client_data_json[13] = 1766029688;
    assert client_data_json[14] = 1130715444;
    assert client_data_json[15] = 1852467504;
    assert client_data_json[16] = 1885632627;
    assert client_data_json[17] = 1633902386;
    assert client_data_json[18] = 961697897;
    assert client_data_json[19] = 1214789697;
    assert client_data_json[20] = 1094795585;
    assert client_data_json[21] = 573317743;
    assert client_data_json[22] = 1919510377;
    assert client_data_json[23] = 1847736866;
    assert client_data_json[24] = 1633771873;
    assert client_data_json[25] = 573317731;
    assert client_data_json[26] = 1919906675;
    assert client_data_json[27] = 1332898151;
    assert client_data_json[28] = 1768825402;
    assert client_data_json[29] = 1717660787;
    assert client_data_json[30] = 1702690816;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}

@external
func test_signer_5{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(68035886564654719105871768,53720227906054259432474415,1042374330031080527485182),
        BigInt3(11868168205554176683298917,51529470237980775115043320,542905823742810284998074),
    );
    let r = BigInt3(74296998440730428146738536,2752801252076334017394554,16636656090868371063600847);
    let s = BigInt3(57358826183012051314835862,15347814872943536831707297,3737687977084843884813824);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 408217;
    assert challenge[1] = 10299169;
    assert challenge[2] = 5755576;
    assert challenge[3] = 11627221;
    assert challenge[4] = 8924337;
    assert challenge[5] = 648760;
    assert challenge[6] = 10369204;
    assert challenge[7] = 10869868;
    assert challenge[8] = 6934518;
    assert challenge[9] = 16061922;
    assert challenge[10] = 7711;


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

    let client_data_json_len = 31;
    let client_data_json_rem = 1;
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
    assert client_data_json[9] = 1114272090;
    assert client_data_json[10] = 1850958696;
    assert client_data_json[11] = 1446595380;
    assert client_data_json[12] = 1935110742;
    assert client_data_json[13] = 1766029688;
    assert client_data_json[14] = 1130715444;
    assert client_data_json[15] = 1852467504;
    assert client_data_json[16] = 1885632627;
    assert client_data_json[17] = 1633902386;
    assert client_data_json[18] = 961697897;
    assert client_data_json[19] = 1214789697;
    assert client_data_json[20] = 1094795585;
    assert client_data_json[21] = 573317743;
    assert client_data_json[22] = 1919510377;
    assert client_data_json[23] = 1847736866;
    assert client_data_json[24] = 1633771873;
    assert client_data_json[25] = 1629629474;
    assert client_data_json[26] = 1668444019;
    assert client_data_json[27] = 1934586473;
    assert client_data_json[28] = 1734962722;
    assert client_data_json[29] = 979788140;
    assert client_data_json[30] = 1936030976;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 83886080;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}

@external
func test_invoke_0{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    let public_key_pt = EcPoint(
        BigInt3(18429879044278490260098551,56029233481007147284932680,2037976146929856349747775),
        BigInt3(70840069926882074167622098,21864696605377867683594565,6822006481759038492420837),
    );
    let r = BigInt3(2223599465377360746283669,25752496995673689528630163,705762337381700509015780);
    let s = BigInt3(58393142204606773616845190,12894059864184526358390250,19065811591212739232406187);

    let type_offset_len = 2;
    let type_offset_rem = 1;

    let challenge_offset_len = 9;
    let challenge_offset_rem = 0;
    let challenge_len = 11;
    let challenge_rem = 1;
    let (challenge) = alloc();
    assert challenge[0] = 203116;
    assert challenge[1] = 3973237;
    assert challenge[2] = 7576440;
    assert challenge[3] = 4692306;
    assert challenge[4] = 11245325;
    assert challenge[5] = 4023842;
    assert challenge[6] = 7866257;
    assert challenge[7] = 5519863;
    assert challenge[8] = 10944597;
    assert challenge[9] = 6294853;
    assert challenge[10] = 47345;


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

    let client_data_json_len = 36;
    let client_data_json_rem = 0;
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
    assert client_data_json[9] = 1098411123;
    assert client_data_json[10] = 1347109425;
    assert client_data_json[11] = 1664447540;
    assert client_data_json[12] = 1379232851;
    assert client_data_json[13] = 1899324238;
    assert client_data_json[14] = 1347901801;
    assert client_data_json[15] = 1698784594;
    assert client_data_json[16] = 1447325235;
    assert client_data_json[17] = 1886863958;
    assert client_data_json[18] = 1497444678;
    assert client_data_json[19] = 1968194850;
    assert client_data_json[20] = 740454258;
    assert client_data_json[21] = 1768384878;
    assert client_data_json[22] = 574235240;
    assert client_data_json[23] = 1953788019;
    assert client_data_json[24] = 976170851;
    assert client_data_json[25] = 1869509746;
    assert client_data_json[26] = 1869376613;
    assert client_data_json[27] = 1915642721;
    assert client_data_json[28] = 1920234089;
    assert client_data_json[29] = 1684497710;
    assert client_data_json[30] = 1734812204;
    assert client_data_json[31] = 576942703;
    assert client_data_json[32] = 1936936818;
    assert client_data_json[33] = 1768384878;
    assert client_data_json[34] = 574252641;
    assert client_data_json[35] = 1819501949;


    let authenticator_data_len = 10;
    let authenticator_data_rem = 3;
    let (authenticator_data) = alloc();
    assert authenticator_data[0] = 547978947;
    assert authenticator_data[1] = 4176460842;
    assert authenticator_data[2] = 3389847498;
    assert authenticator_data[3] = 3141667658;
    assert authenticator_data[4] = 164671177;
    assert authenticator_data[5] = 2421450441;
    assert authenticator_data[6] = 2918684036;
    assert authenticator_data[7] = 4202036947;
    assert authenticator_data[8] = 486539264;
    assert authenticator_data[9] = 0;


    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    );

    return ();
}
