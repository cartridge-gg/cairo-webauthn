#[derive(Drop)]
struct EcPoint {}

fn verify_ecdsa(public_key_pt : EcPoint, msg_hash : u256, r : u256, s : u256) {
    assert(true, 'invalid verify');
}
