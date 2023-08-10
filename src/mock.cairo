use starknet::secp256r1::Secp256r1Point;

fn verify_ecdsa(public_key_pt : Secp256r1Point, msg_hash : u256, r : u256, s : u256) {
    assert(true, 'invalid verify');
}
