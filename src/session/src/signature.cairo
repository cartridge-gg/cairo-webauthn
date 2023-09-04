#[derive(Copy, Drop, Serde)]
struct TxInfoSignature {
    r: felt252,
    s: felt252,
    session_key: felt252,
    session_expires: u64,
    root: felt252,
    //TODO:  Change the naming of proof_len and proofs_len since its veeeeryyy confusing
    proof_len: usize,
    proofs_len: usize,
    proofs: Span<felt252>,
    session_token: Span<felt252>
}

impl FeltSpanTryIntoSignature of TryInto<Span<felt252>, TxInfoSignature> {
    // Convert a span of felts to TxInfoSignature struct
    // The layout of the span should look like:
    // [r, s, session_key, session_expires, root, proofs_len, proof_len, { proofs ... } , session_token_len, { session_token ... }]
    //                                                                   ^-proofs_len-^                      ^-session_token_len-^
    // See details in the implementation
    fn try_into(self: Span<felt252>) -> Option<TxInfoSignature> {
        let proofs_len: usize = (*self[7]).try_into()?;
        let session_token_offset: usize = 8 + proofs_len;
        let session_token_len: usize = (*self[session_token_offset]).try_into()?;

        let proofs: Span<felt252> = self.slice(8, 8 + proofs_len);
        let session_token: Span<felt252> = self
            .slice(session_token_offset + 1, session_token_offset + 1 + session_token_len);

        if self.len() != session_token_offset + 1 + session_token.len() {
            return Option::None(());
        }

        Option::Some(
            TxInfoSignature {
                r: *self[1],
                s: *self[2],
                session_key: *self[3],
                session_expires: (*self[4]).try_into()?,
                root: *self[5],
                proofs_len: proofs_len,
                proof_len: (*self[6]).try_into()?,
                proofs: proofs,
                session_token: session_token
            }
        )
    }
}
