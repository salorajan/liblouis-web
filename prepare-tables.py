import os
import shutil

# List of tables to include (and their dependencies)
REQUIRED_TABLES = [
    # English
    "en-us-g1.ctb", "en-us-g2.ctb", "en-ueb-g1.ctb", "en-ueb-g2.ctb", "en-ueb-math.ctb", "en-chardefs.cti",
    # Spanish
    "es-g1.ctb", "es-g2.ctb", "Es-Es-G0.utb", "es-chardefs.cti",
    # Nemeth
    "nemethdefs.cti", "en-us-mathtext.ctb",
    # Hebrew
    "he-IL.utb", "he-IL-comp8.utb", "he-common-consonants.uti", "he-common-vowels-ihbc.uti",
    # Arabic
    "ar-ar-g1.utb", "ar-ar-g2.ctb", "ar-ar-g1-core.uti", "ar-ar-math.uti",
    # Hindi
    "hi-in-g1.utb", "devanagari.cti",
    # Tamil
    "ta-ta-g1.ctb", "ta.ctb", "tamil.cti",
    # Common Dependencies
    "braille-patterns.cti", "controlchars.cti", "spaces.uti", "digits6Dots.uti", "digits8Dots.uti",
    "latinLetterDef6Dots.uti", "latinLetterDef8Dots.uti", "latinLowercase.uti", "latinUppercaseComp6.uti",
    "eurodefs.cti", "printables.cti", "compress.cti", "corrections.cti"
]

SOURCE_DIR = "liblouis-3.37.0/tables"
TARGET_DIR = "wasm/tables"

if not os.path.exists(TARGET_DIR):
    os.makedirs(TARGET_DIR)

for table in REQUIRED_TABLES:
    src = os.path.join(SOURCE_DIR, table)
    dst = os.path.join(TARGET_DIR, table)
    if os.path.exists(src):
        shutil.copy2(src, dst)
        print(f"Copied {table}")
    else:
        print(f"Warning: {table} not found in {SOURCE_DIR}")

print("\nTable preparation complete.")
