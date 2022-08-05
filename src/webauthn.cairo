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

from src.sha256 import sha256

namespace Webauthn:
    # Verify a webauthn authentication credential.
    # `client_data_json` and `authenticator_data` must be passed
    # as felt* with 32-bit words.
    func verify{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}(
            pub: EcPoint,
            r: BigInt3,
            s: BigInt3,
            challenge_len: felt,
            challenge: felt*,
            client_data_json_len: felt,
            client_data_json: felt*,
            authenticator_data_len: felt,
            authenticator_data: felt*) -> (is_valid: felt):
        alloc_locals

        %{
            print(memory.get_range(ids.client_data_json, ids.client_data_json_len))
        %}
        let (client_data_hash: felt*) = sha256(client_data_json, client_data_json_len)

        let ch0 = client_data_hash[3] + 2 ** 32 * client_data_hash[2] + 2 ** 64 * client_data_hash[1] + 2 ** 96 * client_data_hash[0]
        let ch1 = client_data_hash[7] + 2 ** 32 * client_data_hash[6] + 2 ** 64 * client_data_hash[5] + 2 ** 96 * client_data_hash[4]

        %{ print(hex(ids.ch0), hex(ids.ch1)) %}

        # let (_, r) = unsigned_div_rem(authenticator_data_len, 4)

        # let (msg_data_ptr) = alloc()
        # let msg_data_start_ptr = msg_data_ptr
        # memcpy(msg_data_ptr, authenticator_data, authenticator_data_len - 1)
        # let authenticator_data = authenticator_data + authenticator_data_len - 1
        # let msg_data_ptr = msg_data_ptr + authenticator_data_len - 1

        # let (p0, r0) = unsigned_div_rem(client_data_hash[0], 2 ** 8)
        # let (p1, r1) = unsigned_div_rem(client_data_hash[1], 2 ** 8)
        # let (p2, r2) = unsigned_div_rem(client_data_hash[2], 2 ** 8)
        # let (p3, r3) = unsigned_div_rem(client_data_hash[3], 2 ** 8)
        # let (p4, r4) = unsigned_div_rem(client_data_hash[4], 2 ** 8)
        # let (p5, r5) = unsigned_div_rem(client_data_hash[5], 2 ** 8)
        # let (p6, r6) = unsigned_div_rem(client_data_hash[6], 2 ** 8)
        # let (p7, r7) = unsigned_div_rem(client_data_hash[7], 2 ** 8)

        # assert msg_data_ptr[0] = authenticator_data[0] * 2 ** 24 + p0
        # assert msg_data_ptr[1] = r0 * 2 ** 24 + p1
        # assert msg_data_ptr[2] = r1 * 2 ** 24 + p2
        # assert msg_data_ptr[3] = r2 * 2 ** 24 + p3
        # assert msg_data_ptr[4] = r3 * 2 ** 24 + p4
        # assert msg_data_ptr[5] = r4 * 2 ** 24 + p5
        # assert msg_data_ptr[6] = r5 * 2 ** 24 + p6
        # assert msg_data_ptr[7] = r6 * 2 ** 24 + p7
        # assert msg_data_ptr[8] = r7 * 2 ** 24

        # %{
        #     print(memory.get_range(ids.client_data_hash, 8))
        #     print(memory.get_range(ids.msg_data_start_ptr, 18))
        # %}

        # let (msg_hash: felt*) = sha256(msg_data_start_ptr, authenticator_data_len + 8)

        # let h0 = msg_hash[3] + 2 ** 32 * msg_hash[2] + 2 ** 64 * msg_hash[1] + 2 ** 96 * msg_hash[0]
        # let h1 = msg_hash[7] + 2 ** 32 * msg_hash[6] + 2 ** 64 * msg_hash[5] + 2 ** 96 * msg_hash[4]

        # %{ print(hex(ids.h0), hex(ids.h1)) %}

        # We're doing using the sphinx cairo sha256 implementation until the cario hints support more efficient sha256
        # let (local sha256_ptr_start : felt*) = alloc()
        # let sha256_ptr = sha256_ptr_start
        # let (output: felt*) = sha256{sha256_ptr=sha256_ptr}(input, 32)
        # finalize_sha256(sha256_ptr, sha256_ptr)


        # Construct 86bit hash limbs
        # let (h02) = bitwise_and(msg_hash[5], 4194303)
        # let h0 = msg_hash[7] + 2 ** 32 * msg_hash[6] + 2 ** 64 * h02

        # let (h10, r10) = unsigned_div_rem(msg_hash[5], 4194304)
        # let (h13) = bitwise_and(msg_hash[2], 4095)
        # let h1 = h10 + msg_hash[4] * 2 ** 10 + msg_hash[3] * 2 ** 42 + h13 * 2 ** 74

        # let (h20, r20) = unsigned_div_rem(msg_hash[2], 4096)
        # let h2 = h20 + msg_hash[1] * 2 ** 20 + msg_hash[0] * 2 ** 52

        # let hash_bigint3 = BigInt3(h0, h1, h2)
        # verify_ecdsa(
        #     public_key_pt=pub,
        #     msg_hash=hash_bigint3,
        #     r=r,
        #     s=s)

        return (is_valid=TRUE)
    end
end
