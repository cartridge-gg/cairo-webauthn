use core::array::ArrayTrait;
use webauthn_session::signature::ImplSignatureProofs;

fn signature_proofs_endpoint(
    arr: Array<felt252>, proof_length: usize
) -> Option<Array<Span<felt252>>> {
    let proofs = ImplSignatureProofs::try_new(arr.span(), proof_length)?;
    let mut result: Array<Span<felt252>> = array![];
    let mut i = 0;
    let count = arr.len() / proof_length;
    loop {
        if i >= count {
            break;
        }
        let proof = proofs.at(i);
        result.append(proof);
        i += 1;
    };
    Option::Some(result)
}
