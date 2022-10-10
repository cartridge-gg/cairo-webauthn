%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.bitwise import bitwise_and
from starkware.cairo.common.bool import TRUE, FALSE
from starkware.cairo.common.math import unsigned_div_rem
from starkware.cairo.common.memcpy import memcpy
from starkware.cairo.common.alloc import alloc

from src.ec import EcPoint
from src.bigint import BigInt3
from src.ecdsa import verify_ecdsa
from src.base64url import Base64URL
from src.sha256 import sha256, finalize_sha256

namespace Webauthn {
    // @notice Verify a webauthn authentication credential according to: https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
    // @dev `client_data_json` and `authenticator_data` must be passed
    // as felt* of 32-bit felts and `challenge` should be passed as 24-bit felts.
    // The challenge is subsequently base64 encoded into 32-bit felts for comparison
    // with the challenge embedded in the `client_data_json`. We operate on 32-bit felts
    // since the sha256 implementation expects them and it is more efficient to handle
    // the data processing offchain.
    //
    // @param pub (EcPoint): Public Key point.
    // @param r (BigInt3): `r` component of the signature.
    // @param s (BigInt3): `s` component of the signature.
    // @param type_offset_len (felt): offset until type value starts in the client_data_json payload.
    // @param type_offset_rem (felt):
    // @param challenge_offset_len (felt): offset until challenge value starts in the client_data_json payload.
    // @param challenge_offset_rem (felt):
    // @param challenge_len (felt):
    // @param challenge_rem: felt,
    // @param challenge (felt*):
    // @param origin_offset_len (felt):
    // @param origin_offset_rem (felt):
    // @param origin_len (felt):
    // @param origin (felt*):
    // @param client_data_json_len (felt):
    // @param client_data_json_rem (felt):
    // @param client_data_json (felt*):
    // @param authenticator_data_len (felt):
    // @param authenticator_data_rem (felt):
    // @param authenticator_data (felt):
    func verify{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}(
        pub: EcPoint,
        r: BigInt3,
        s: BigInt3,
        type_offset_len: felt,
        type_offset_rem: felt,
        challenge_offset_len: felt,
        challenge_offset_rem: felt,
        challenge_len: felt,
        challenge_rem: felt,
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
        authenticator_data: felt*,
    ) -> (is_valid: felt) {
        alloc_locals;

        // 11. Verify that the value of C.type is the string webauthn.get
        // Skipping for now

        // 12. Verify that the value of C.challenge equals the base64url encoding of options.challenge.
        _verify_challenge(
            client_data_json,
            challenge_offset_len,
            challenge_offset_rem,
            challenge_len,
            challenge_rem,
            challenge,
        );

        // 13. Verify that the value of C.origin matches the Relying Party's origin.
        // Skipping for now.

        // 15. Verify that the rpIdHash in authData is the SHA-256 hash of the RP ID expected by the Relying Party.
        // Skipping for now. This protects against authenticator cloning which is generally not
        // a concern of blockchain wallets today.
        // Authenticator Data layout looks like: [ RP ID hash - 32 bytes ] [ Flags - 1 byte ] [ Counter - 4 byte ] [ ... ]
        // See: https://w3c.github.io/webauthn/#sctn-authenticator-data

        // 16-17: Verify that the User Present bit of the flags in authData is set.
        _verify_auth_flags(authenticator_data);

        let (local sha256_ptr_start : felt*) = alloc();
        let sha256_ptr = sha256_ptr_start;
        let (client_data_hash: felt*) = sha256{sha256_ptr=sha256_ptr}(client_data_json, client_data_json_len * 4 - client_data_json_rem);
        finalize_sha256(sha256_ptr, sha256_ptr);

        let (msg_data_ptr) = alloc();
        let msg_data_start_ptr = msg_data_ptr;

        _concat_msg_data{msg_data_ptr=msg_data_ptr}(
            authenticator_data_len, authenticator_data_rem, authenticator_data, client_data_hash
        );

        let (local sha256_ptr_start : felt*) = alloc();
        let sha256_ptr = sha256_ptr_start;
        let (msg_hash: felt*) = sha256{sha256_ptr=sha256_ptr}(msg_data_start_ptr, authenticator_data_len * 4 - authenticator_data_rem + 32);
        finalize_sha256(sha256_ptr, sha256_ptr);

        // Construct 86bit hash limbs
        let (h02) = bitwise_and(msg_hash[5], 4194303);
        let h0 = msg_hash[7] + 2 ** 32 * msg_hash[6] + 2 ** 64 * h02;

        let (h10, r10) = unsigned_div_rem(msg_hash[5], 4194304);
        let (h13) = bitwise_and(msg_hash[2], 4095);
        let h1 = h10 + msg_hash[4] * 2 ** 10 + msg_hash[3] * 2 ** 42 + h13 * 2 ** 74;

        let (h20, r20) = unsigned_div_rem(msg_hash[2], 4096);
        let h2 = h20 + msg_hash[1] * 2 ** 20 + msg_hash[0] * 2 ** 52;

        let hash_bigint3 = BigInt3(h0, h1, h2);
        verify_ecdsa(public_key_pt=pub, msg_hash=hash_bigint3, r=r, s=s);

        return (is_valid=TRUE);
    }

    // Recursively verifies the provided challenge is embedded in the client_data_json.
    func _verify_challenge{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}(
        client_data_json: felt*,
        challenge_offset_len: felt,
        challenge_offset_rem: felt,
        challenge_len: felt,
        challenge_rem: felt,
        challenge: felt*,
    ) {
        alloc_locals;

        let (shifted) = _shift_challenge(
            client_data_json, challenge_offset_len, challenge_offset_rem
        );
        let c = challenge[0];

        if (challenge_len == 1) {
            if (challenge_rem == 0) {
                let (c0, c1, c2, c3, _) = Base64URL.encode3(c);
                let encoded = c0 * 2 ** 24 + c1 * 2 ** 16 + c2 * 2 ** 8 + c3;
                assert encoded = shifted;
                return ();
            }

            if (challenge_rem == 1) {
                let (c0, c1, c2, c3, _) = Base64URL.encode3(c * 2 ** 8);
                let encoded = c0 * 2 ** 24 + c1 * 2 ** 16 + c2 * 2 ** 8;
                let (masked) = bitwise_and(shifted, 4294967040);
                assert encoded = masked;
                return ();
            }

            if (challenge_rem == 2) {
                let (c0, c1, c2, c3, _) = Base64URL.encode3(c * 2 ** 16);
                let encoded = c0 * 2 ** 24 + c1 * 2 ** 16;
                let (masked) = bitwise_and(shifted, 4294901760);
                assert encoded = masked;
                return ();
            }
        }

        let (c0, c1, c2, c3, _) = Base64URL.encode3(c);
        let encoded = c0 * 2 ** 24 + c1 * 2 ** 16 + c2 * 2 ** 8 + c3;
        assert shifted = encoded;
        return _verify_challenge(
            client_data_json,
            challenge_offset_len + 1,
            challenge_offset_rem,
            challenge_len - 1,
            challenge_rem,
            challenge + 1,
        );
    }

    // Verify the User Present and User Verified flags are set.
    //   Bit 0: User Present (UP) result.
    //   Bit 2: User Verified (UV) result.
    func _verify_auth_flags{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}(
        authenticator_data: felt*
    ) {
        let flags = authenticator_data[8];
        let (p, _) = unsigned_div_rem(flags, 2 ** 24);
        let (uv) = bitwise_and(p, 1);
        let (up) = bitwise_and(p, 4);

        assert uv = 1;
        assert up = 4;

        return ();
    }

    // Aligns a challenge 32bit word to client_data_json as necessary for comparison.
    func _shift_challenge{range_check_ptr}(
        client_data_json: felt*, challenge_offset_len: felt, challenge_offset_rem: felt
    ) -> (shifted: felt) {
        if (challenge_offset_rem == 1) {
            let (_, r) = unsigned_div_rem(client_data_json[challenge_offset_len], 2 ** 24);
            let (p, _) = unsigned_div_rem(client_data_json[challenge_offset_len], 2 ** 24);
            let shifted = r * 2 ** 8 + p;
            return (shifted,);
        }

        if (challenge_offset_rem == 2) {
            let (_, r) = unsigned_div_rem(client_data_json[challenge_offset_len], 2 ** 16);
            let (p, _) = unsigned_div_rem(client_data_json[challenge_offset_len], 2 ** 16);
            let shifted = r * 2 ** 16 + p;
            return (shifted,);
        }

        if (challenge_offset_rem == 3) {
            let (_, r) = unsigned_div_rem(client_data_json[challenge_offset_len], 2 ** 8);
            let (p, _) = unsigned_div_rem(client_data_json[challenge_offset_len], 2 ** 8);
            let shifted = r * 2 ** 24 + p;
            return (shifted,);
        }

        let shifted = client_data_json[challenge_offset_len];
        return (shifted,);
    }

    // Concatenates authenticator_data + sha256(client_data_json) as necessary to produce the correct signed hash.
    // Since sha256 expects 32bit words, it can be necessary to shift the sha256(client_data_json) in order to
    // correctly align the bits.
    func _concat_msg_data{range_check_ptr, bitwise_ptr: BitwiseBuiltin*, msg_data_ptr: felt*}(
        authenticator_data_len: felt,
        authenticator_data_rem: felt,
        authenticator_data: felt*,
        client_data_hash: felt*,
    ) {
        if (authenticator_data_rem == 0) {
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len);
            let msg_data_ptr = msg_data_ptr + authenticator_data_len;
            memcpy(msg_data_ptr, client_data_hash, 8);
            return ();
        }

        if (authenticator_data_rem == 3) {
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len - 1);
            let authenticator_data = authenticator_data + authenticator_data_len - 1;
            let msg_data_ptr = msg_data_ptr + authenticator_data_len - 1;

            let (p0, r0) = unsigned_div_rem(client_data_hash[0], 2 ** 8);
            let (p1, r1) = unsigned_div_rem(client_data_hash[1], 2 ** 8);
            let (p2, r2) = unsigned_div_rem(client_data_hash[2], 2 ** 8);
            let (p3, r3) = unsigned_div_rem(client_data_hash[3], 2 ** 8);
            let (p4, r4) = unsigned_div_rem(client_data_hash[4], 2 ** 8);
            let (p5, r5) = unsigned_div_rem(client_data_hash[5], 2 ** 8);
            let (p6, r6) = unsigned_div_rem(client_data_hash[6], 2 ** 8);
            let (p7, r7) = unsigned_div_rem(client_data_hash[7], 2 ** 8);

            assert msg_data_ptr[0] = authenticator_data[0] * 2 ** 24 + p0;
            assert msg_data_ptr[1] = r0 * 2 ** 24 + p1;
            assert msg_data_ptr[2] = r1 * 2 ** 24 + p2;
            assert msg_data_ptr[3] = r2 * 2 ** 24 + p3;
            assert msg_data_ptr[4] = r3 * 2 ** 24 + p4;
            assert msg_data_ptr[5] = r4 * 2 ** 24 + p5;
            assert msg_data_ptr[6] = r5 * 2 ** 24 + p6;
            assert msg_data_ptr[7] = r6 * 2 ** 24 + p7;
            assert msg_data_ptr[8] = r7 * 2 ** 24;

            return ();
        }

        if (authenticator_data_rem == 2) {
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len - 1);
            let authenticator_data = authenticator_data + authenticator_data_len - 1;
            let msg_data_ptr = msg_data_ptr + authenticator_data_len - 1;

            let (p0, r0) = unsigned_div_rem(client_data_hash[0], 2 ** 16);
            let (p1, r1) = unsigned_div_rem(client_data_hash[1], 2 ** 16);
            let (p2, r2) = unsigned_div_rem(client_data_hash[2], 2 ** 16);
            let (p3, r3) = unsigned_div_rem(client_data_hash[3], 2 ** 16);
            let (p4, r4) = unsigned_div_rem(client_data_hash[4], 2 ** 16);
            let (p5, r5) = unsigned_div_rem(client_data_hash[5], 2 ** 16);
            let (p6, r6) = unsigned_div_rem(client_data_hash[6], 2 ** 16);
            let (p7, r7) = unsigned_div_rem(client_data_hash[7], 2 ** 16);

            assert msg_data_ptr[0] = authenticator_data[0] * 2 ** 16 + p0;
            assert msg_data_ptr[1] = r0 * 2 ** 16 + p1;
            assert msg_data_ptr[2] = r1 * 2 ** 16 + p2;
            assert msg_data_ptr[3] = r2 * 2 ** 16 + p3;
            assert msg_data_ptr[4] = r3 * 2 ** 16 + p4;
            assert msg_data_ptr[5] = r4 * 2 ** 16 + p5;
            assert msg_data_ptr[6] = r5 * 2 ** 16 + p6;
            assert msg_data_ptr[7] = r6 * 2 ** 16 + p7;
            assert msg_data_ptr[8] = r7 * 2 ** 16;

            return ();
        }

        if (authenticator_data_rem == 1) {
            memcpy(msg_data_ptr, authenticator_data, authenticator_data_len - 1);
            let authenticator_data = authenticator_data + authenticator_data_len - 1;
            let msg_data_ptr = msg_data_ptr + authenticator_data_len - 1;

            let (p0, r0) = unsigned_div_rem(client_data_hash[0], 2 ** 24);
            let (p1, r1) = unsigned_div_rem(client_data_hash[1], 2 ** 24);
            let (p2, r2) = unsigned_div_rem(client_data_hash[2], 2 ** 24);
            let (p3, r3) = unsigned_div_rem(client_data_hash[3], 2 ** 24);
            let (p4, r4) = unsigned_div_rem(client_data_hash[4], 2 ** 24);
            let (p5, r5) = unsigned_div_rem(client_data_hash[5], 2 ** 24);
            let (p6, r6) = unsigned_div_rem(client_data_hash[6], 2 ** 24);
            let (p7, r7) = unsigned_div_rem(client_data_hash[7], 2 ** 24);

            assert msg_data_ptr[0] = authenticator_data[0] * 2 ** 8 + p0;
            assert msg_data_ptr[1] = r0 * 2 ** 8 + p1;
            assert msg_data_ptr[2] = r1 * 2 ** 8 + p2;
            assert msg_data_ptr[3] = r2 * 2 ** 8 + p3;
            assert msg_data_ptr[4] = r3 * 2 ** 8 + p4;
            assert msg_data_ptr[5] = r4 * 2 ** 8 + p5;
            assert msg_data_ptr[6] = r5 * 2 ** 8 + p6;
            assert msg_data_ptr[7] = r6 * 2 ** 8 + p7;
            assert msg_data_ptr[8] = r7 * 2 ** 8;

            return ();
        }

        return ();
    }
}
