use core::integer::U32Div;
use core::Into;
use debug::PrintTrait;

#[derive(Copy, Drop, Serde)]
struct TxInfoSignature {
    r: felt252,
    s: felt252,
    session_key: felt252,
    session_expires: u64,
    root: felt252,
    proofs: SignatureProofs,
    session_token: Span<felt252>
}

impl FeltSpanTryIntoSignature of TryInto<Span<felt252>, TxInfoSignature> {
    // Convert a span of felts to TxInfoSignature struct
    // The layout of the span should look like:
    // [r, s, session_key, session_expires, root, proof_len, proofs_len, { proofs ... } , session_token_len, { session_token ... }]
    //                                                                   ^-proofs_len-^                      ^-session_token_len-^
    // See details in the implementation
    fn try_into(self: Span<felt252>) -> Option<TxInfoSignature> {
        let single_proof_len: usize = (*self[6]).try_into()?;
        let total_proofs_len: usize = (*self[7]).try_into()?;
        let session_token_offset: usize = 8 + total_proofs_len;
        let session_token_len: usize = (*self[session_token_offset]).try_into()?;

        if self.len() != session_token_offset + 1 + session_token_len {
            return Option::None(());
        }

        let session_token: Span<felt252> = self
            .slice(session_token_offset + 1, session_token_len);

        let proofs_flat: Span<felt252> = self.slice(8, total_proofs_len);
        let proofs = ImplSignatureProofs::try_new(proofs_flat, single_proof_len)?;

        Option::Some(
            TxInfoSignature {
                r: *self[1],
                s: *self[2],
                session_key: *self[3],
                session_expires: (*self[4]).try_into()?,
                root: *self[5],
                proofs: proofs,
                session_token: session_token
            }
        )
    }
}

#[derive(Copy, Drop, Serde)]
struct SignatureProofs {
    proofs_flat: Span<felt252>,
    single_proof_len: usize,
}

#[generate_trait]
impl ImplSignatureProofs of SignatureProofsTrait {
    fn try_new(proofs_flat: Span<felt252>, single_proof_len: usize) -> Option<SignatureProofs> {
        if proofs_flat.len() % single_proof_len != 0 {
            return Option::None(());
        }
        Option::Some(SignatureProofs {
            proofs_flat,
            single_proof_len
        })
    }
    fn len(self: SignatureProofs) -> usize {
        U32Div::div(self.proofs_flat.len(), self.single_proof_len)
    }
    fn at(self: SignatureProofs, index: usize) -> Span<felt252> {
        self.proofs_flat.slice(index * self.single_proof_len, self.single_proof_len)
    }
}
