#!/bin/bash

# Exit on error
set -e

# 1. Prepare Tables
echo "Preparing tables..."
python3 prepare-tables.py

# 2. Build Liblouis using Emscripten
cd liblouis-3.37.0

echo "Configuring liblouis for WebAssembly..."
emconfigure ./configure --disable-shared --enable-static --without-yaml

echo "Compiling liblouis..."
emmake make -j$(nproc)

# 3. Create Wasm Module
echo "Creating Wasm module..."
mkdir -p ../dist

emcc -O3 \
    liblouis/.libs/liblouis.a \
    gnulib/.libs/libgnu.a \
    -o ../dist/liblouis.js \
    -s EXPORTED_FUNCTIONS='["_lou_version", "_lou_translateString", "_lou_setDataPath", "_lou_free"]' \
    -s EXPORTED_RUNTIME_METHODS='["ccall", "cwrap", "allocate", "stringToUTF16", "UTF16ToString", "ALLOC_NORMAL"]' \
    -s MODULARIZE=1 \
    -s EXPORT_NAME='Liblouis' \
    -s ALLOW_MEMORY_GROWTH=1 \
    --preload-file ../wasm/tables@/tables \
    -I. -Iliblouis

echo "Build complete! Files are in the 'dist' directory."
