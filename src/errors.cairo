use core::traits::Into;

enum AuthnError{
    TransportNotAllowed,
    GetCredentialRejected,
    ResponseIsNotAttestation,
    CredentialNotAllowed,
    KeyRetirevalFailed,
    IdentifiedUsersMismatch,
    ChallengeMismatch,
    OriginMismatch,
    InvalidAuthData,
    RelyingPartyIdHashMismatch,
    UserFlagsMismatch
}

// Probably this should not exist
enum StoreError {
    KeyRetirevalFailed
}

impl AuthnErrorIntoResultT<T>
    of Into<AuthnError, Result<T, AuthnError>> {
    fn into(self: AuthnError) -> Result<T, AuthnError>{
        Result::Err(self)
    }
}

impl RTSEIntoRTAE<T>
    of Into<Result<T, StoreError>, Result<T, AuthnError>> {
    fn into(self: Result<T, StoreError>) -> Result<T, AuthnError>{
        match self {
            Result::Ok(t) => Result::Ok(t),
            Result::Err(e) => match e {
                StoreError::KeyRetirevalFailed => AuthnError::KeyRetirevalFailed.into()
            }
        }
    }
}
