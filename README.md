# cairo-webauthn

A library for webauthn credential authentication.

## Usage

```cairo
Webauthn.verify(public_key, r, s,
    type_offset_len, type_offset_rem,
    challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
    origin_offset_len, origin_offset_rem, origin_len, origin,
    client_data_json_len, client_data_json_rem, client_data_json,
    authenticator_data_len, authenticator_data_rem, authenticator_data
)
```

## Development

```sh
pip install webauthn pyasn1
```
