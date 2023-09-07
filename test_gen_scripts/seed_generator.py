from typing import Any, Generator


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
