from hashlib import sha256
def get_array_from_text(text, func_name):
    res = f"fn {func_name}() -> Array<u8> " + "{\n    let mut res = ArrayTrait::<u8>::new();"
    for char in text:
        res += "\n    res.append(" + hex(ord(char)) + ");"
    return res + "\n    res\n}\n"

def get_array_from_hex(text, func_name):
    res = f"fn {func_name}() -> Array<u8> " + "{\n    let mut res = ArrayTrait::<u8>::new();"
    for i in range(0,len(text),2):
        res += "\n    res.append(0x" + text[i] + text[i+1] + ");"
    return res + "\n    res\n}\n"

def get_client_data(typee, challenge, origin):
    return '{"type":"' + typee + '","challenge":"' + challenge + '","origin":"' + origin + '","crossOrigin":false}';


def get_auth_data():
    res = bytes([0xe3,0xb0,0xc4,0x42,0x98,0xfc,0x1c,0x14,0x9a,0xfb,0xf4,0xc8,0x99,0x6f,0xb9,0x24,0x27,0xae,0x41,0xe4,0x64,0x9b,0x93,0x4c,0xa4,0x95,0x99,0x1b,0x78,0x52,0xb8,0x55]) + bytes([5]) + bytes([0,0,0,0]);
    return res.hex()

# client_data_json = get_client_data("webauthn.get", "sample_challenge", "sample_origin")

# print(get_array_from_hex(get_auth_data(), "get_auth"))

# print(get_array_from_text(client_data_json, "get_client_data_simple"))

# print(*enumerate(client_data_json), sep='\n')
# print(get_array_from_text("sample_challenge", "get_sample_challenge"))

# print(get_array_from_text("sample_origin", "get_sample_origin"))

# print(sha256(bytes(client_data_json, 'utf-8')).hexdigest())
# print(get_auth_data())

# "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b8550500000000b83a3cb81016bdfd152f23bc0a6aee7ae0e0db490ed7ff4656d442172e1d9599"
# print(get_array_from_hex("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b8550500000000b83a3cb81016bdfd152f23bc0a6aee7ae0e0db490ed7ff4656d442172e1d9599", "get_sample_expected"))


# client_data_json = get_client_data("webauthn.get", 
# "Challenge Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
# "Origin Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
# )

# print(get_array_from_text(client_data_json, "get_big_client_data"))
# print(get_array_from_text("Challenge Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "get_big_challenge"))
# print(get_array_from_text("Origin Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "get_big_origin"))

# print(sha256(bytes(client_data_json, 'utf-8')).hexdigest())
# print(get_auth_data())

# print(get_array_from_hex("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b8550500000000deb6fcaf4a9a5421ae207c48c2d63201b951e53bec539ec716e98bef0ffe2335", "get_big_expected"))
