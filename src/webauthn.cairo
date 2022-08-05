%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.bitwise import bitwise_and
from starkware.cairo.common.bool import (TRUE)
from starkware.cairo.common.math import unsigned_div_rem
from starkware.cairo.common.memcpy import memcpy
from starkware.cairo.common.alloc import alloc

from src.ec import EcPoint
from src.bigint import BigInt3
from src.ecdsa import verify_ecdsa

from src.sha256 import sha256, finalize_sha256

namespace Webauthn:
    # Verify a webauthn authentication credential according to: https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
    # `client_data_json` and `authenticator_data` must be passed
    # as felt* with 32-bit words.
    func verify{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}(
            pub: EcPoint,
            r: BigInt3,
            s: BigInt3,
            type_offset_len: felt,
            type_offset_rem: felt,
            challenge_offset_len: felt,
            challenge_offset_rem: felt,
            challenge_len: felt,
            challenge: felt*,
            origin_offset_len: felt,
            origin_offset_rem: felt,
            origin_len: felt,
            origin: felt*,
            client_data_json_len: felt,
            client_data_json_rem: felt,
            client_data_json: felt*,
            authenticator_data_len: felt,
            authenticator_data_rem: felt,
            authenticator_data: felt*) -> (is_valid: felt):
        alloc_locals

        # 11. Verify that the value of C.type is the string webauthn.get


        # 12. Verify that the value of C.challenge equals the base64url encoding of options.challenge.
        

        # 13. Verify that the value of C.origin matches the Relying Party's origin.

        # 15. Verify that the rpIdHash in authData is the SHA-256 hash of the RP ID expected by the Relying Party.

        # 16-17: Verify that the User Present bit of the flags in authData is set.

        # We're doing using the sphinx cairo sha256 implementation until the cario hints support more efficient sha256
        # let (client_data_hash: felt*) = sha256(client_data_json, client_data_json_len * 4 - client_data_json_rem)
        let (local sha256_ptr_start : felt*) = alloc()
        let sha256_ptr = sha256_ptr_start
        let (client_data_hash: felt*) = sha256{sha256_ptr=sha256_ptr}(client_data_json, client_data_json_len * 4 - client_data_json_rem)
        finalize_sha256(sha256_ptr, sha256_ptr)

        let (msg_data_ptr) = alloc()
        let msg_data_start_ptr = msg_data_ptr

        _concat_msg_data{msg_data_ptr=msg_data_ptr}(authenticator_data_len, authenticator_data_rem, authenticator_data, client_data_hash)

        # We're doing using the sphinx cairo sha256 implementation until the cario hints support more efficient sha256
        # let (msg_hash: felt*) = sha256(msg_data_start_ptr, authenticator_data_len * 4 - authenticator_data_rem + 32)
        let (local sha256_ptr_start : felt*) = alloc()
        let sha256_ptr = sha256_ptr_start
        let (msg_hash: felt*) = sha256{sha256_ptr=sha256_ptr}(msg_data_start_ptr, authenticator_data_len * 4 - authenticator_data_rem + 32)
        finalize_sha256(sha256_ptr, sha256_ptr)

        # Construct 86bit hash limbs
        let (h02) = bitwise_and(msg_hash[5], 4194303)
        let h0 = msg_hash[7] + 2 ** 32 * msg_hash[6] + 2 ** 64 * h02

        let (h10, r10) = unsigned_div_rem(msg_hash[5], 4194304)
        let (h13) = bitwise_and(msg_hash[2], 4095)
        let h1 = h10 + msg_hash[4] * 2 ** 10 + msg_hash[3] * 2 ** 42 + h13 * 2 ** 74

        let (h20, r20) = unsigned_div_rem(msg_hash[2], 4096)
        let h2 = h20 + msg_hash[1] * 2 ** 20 + msg_hash[0] * 2 ** 52

        let hash_bigint3 = BigInt3(h0, h1, h2)
        verify_ecdsa(
            public_key_pt=pub,
            msg_hash=hash_bigint3,
            r=r,
            s=s)

        return (is_valid=TRUE)
    end

    func _concat_msg_data{range_check_ptr, bitwise_ptr: BitwiseBuiltin*, msg_data_ptr: felt*}(
        authenticator_data_len: felt, authenticator_data_rem: felt, authenticator_data: felt*, client_data_hash: felt*
    ):
        if authenticator_data_rem == 0:
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len)
            let msg_data_ptr = msg_data_ptr + authenticator_data_len
            memcpy(msg_data_ptr, client_data_hash, 8)
            return ()
        end

        if authenticator_data_rem == 1:
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len - 1)
            let authenticator_data = authenticator_data + authenticator_data_len - 1
            let msg_data_ptr = msg_data_ptr + authenticator_data_len - 1

            let (p0, r0) = unsigned_div_rem(client_data_hash[0], 2 ** 24)
            let (p1, r1) = unsigned_div_rem(client_data_hash[1], 2 ** 24)
            let (p2, r2) = unsigned_div_rem(client_data_hash[2], 2 ** 24)
            let (p3, r3) = unsigned_div_rem(client_data_hash[3], 2 ** 24)
            let (p4, r4) = unsigned_div_rem(client_data_hash[4], 2 ** 24)
            let (p5, r5) = unsigned_div_rem(client_data_hash[5], 2 ** 24)
            let (p6, r6) = unsigned_div_rem(client_data_hash[6], 2 ** 24)
            let (p7, r7) = unsigned_div_rem(client_data_hash[7], 2 ** 24)

            assert msg_data_ptr[0] = authenticator_data[0] * 2 ** 8 + p0
            assert msg_data_ptr[1] = r0 * 2 ** 8 + p1
            assert msg_data_ptr[2] = r1 * 2 ** 8 + p2
            assert msg_data_ptr[3] = r2 * 2 ** 8 + p3
            assert msg_data_ptr[4] = r3 * 2 ** 8 + p4
            assert msg_data_ptr[5] = r4 * 2 ** 8 + p5
            assert msg_data_ptr[6] = r5 * 2 ** 8 + p6
            assert msg_data_ptr[7] = r6 * 2 ** 8 + p7
            assert msg_data_ptr[8] = r7 * 2 ** 8

            return()
        end

        if authenticator_data_rem == 2:
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len - 1)
            let authenticator_data = authenticator_data + authenticator_data_len - 1
            let msg_data_ptr = msg_data_ptr + authenticator_data_len - 1

            let (p0, r0) = unsigned_div_rem(client_data_hash[0], 2 ** 16)
            let (p1, r1) = unsigned_div_rem(client_data_hash[1], 2 ** 16)
            let (p2, r2) = unsigned_div_rem(client_data_hash[2], 2 ** 16)
            let (p3, r3) = unsigned_div_rem(client_data_hash[3], 2 ** 16)
            let (p4, r4) = unsigned_div_rem(client_data_hash[4], 2 ** 16)
            let (p5, r5) = unsigned_div_rem(client_data_hash[5], 2 ** 16)
            let (p6, r6) = unsigned_div_rem(client_data_hash[6], 2 ** 16)
            let (p7, r7) = unsigned_div_rem(client_data_hash[7], 2 ** 16)

            assert msg_data_ptr[0] = authenticator_data[0] * 2 ** 16 + p0
            assert msg_data_ptr[1] = r0 * 2 ** 16 + p1
            assert msg_data_ptr[2] = r1 * 2 ** 16 + p2
            assert msg_data_ptr[3] = r2 * 2 ** 16 + p3
            assert msg_data_ptr[4] = r3 * 2 ** 16 + p4
            assert msg_data_ptr[5] = r4 * 2 ** 16 + p5
            assert msg_data_ptr[6] = r5 * 2 ** 16 + p6
            assert msg_data_ptr[7] = r6 * 2 ** 16 + p7
            assert msg_data_ptr[8] = r7 * 2 ** 16

            return()
        end

        if authenticator_data_rem == 3:
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len - 1)
            let authenticator_data = authenticator_data + authenticator_data_len - 1
            let msg_data_ptr = msg_data_ptr + authenticator_data_len - 1

            let (p0, r0) = unsigned_div_rem(client_data_hash[0], 2 ** 8)
            let (p1, r1) = unsigned_div_rem(client_data_hash[1], 2 ** 8)
            let (p2, r2) = unsigned_div_rem(client_data_hash[2], 2 ** 8)
            let (p3, r3) = unsigned_div_rem(client_data_hash[3], 2 ** 8)
            let (p4, r4) = unsigned_div_rem(client_data_hash[4], 2 ** 8)
            let (p5, r5) = unsigned_div_rem(client_data_hash[5], 2 ** 8)
            let (p6, r6) = unsigned_div_rem(client_data_hash[6], 2 ** 8)
            let (p7, r7) = unsigned_div_rem(client_data_hash[7], 2 ** 8)

            assert msg_data_ptr[0] = authenticator_data[0] * 2 ** 24 + p0
            assert msg_data_ptr[1] = r0 * 2 ** 24 + p1
            assert msg_data_ptr[2] = r1 * 2 ** 24 + p2
            assert msg_data_ptr[3] = r2 * 2 ** 24 + p3
            assert msg_data_ptr[4] = r3 * 2 ** 24 + p4
            assert msg_data_ptr[5] = r4 * 2 ** 24 + p5
            assert msg_data_ptr[6] = r5 * 2 ** 24 + p6
            assert msg_data_ptr[7] = r6 * 2 ** 24 + p7
            assert msg_data_ptr[8] = r7 * 2 ** 24

            return()
        end
        return ()
    end
end
