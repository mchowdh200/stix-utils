import os
from glob import glob


def find_crams(dir: str) -> list[str]:
    cram_files = glob(os.path.join(dir, "*.cram"))
    return cram_files


def get_basenames(files: list[str]) -> list[str]:
    """Removes directories and file extension"""
    return [os.path.basename(os.path.splitext(f)[0]) for f in files]
