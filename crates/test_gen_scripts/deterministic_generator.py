from typing import Any, Generator
import string

def get_seed_generator() -> Generator[bytes, Any, None]:
    cur_seed = 1
    while True:
        cur_seed += 1
        byte_length = (cur_seed.bit_length() + 7) // 8
        yield cur_seed.to_bytes(byte_length, "big")


_SEED_GENERATOR = get_seed_generator()


def generate_next_seed() -> bytes:
    """
    Generate and return the next seed from a global sequence.

    This function operates on a global context and deterministically
    produces a sequence of seeds. Each invocation returns a different seed.
    The same sequence of seeds is produced every time the Python script is run.

    Returns:
        bytes: The next seed in the sequence.
    """
    global _SEED_GENERATOR
    return next(_SEED_GENERATOR)

def get_string_generator() -> Generator[str, None, None]:
    characters = string.ascii_letters + string.digits
    cur_seed = 5
    cur_string = "aaaaa"
    while True:
        cur_seed += 1

        if(len(cur_string) >= 100):
            cur_string[100 % cur_seed] =  cur_seed[((100 % cur_seed) + 1) % len(characters)]
        else:
            cur_string += characters[cur_seed % len(characters)]

        yield cur_string

_STRING_GENERATOR = get_string_generator()

def generate_deterministic_string() -> str:
    global _STRING_GENERATOR
    return next(_STRING_GENERATOR)
    
