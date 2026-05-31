# Liblouis Web Deployment Plan

This document outlines the steps to compile Liblouis to WebAssembly (Wasm) and deploy it as a functional web page.

## Phase 1: Research & Feasibility (Completed)
- [x] Verify project structure and Emscripten readiness.
- [x] Identify key export functions (`lou_translateString`, etc.).
- [x] Analyze table dependencies.

## Phase 2: Compilation Strategy
1. **Emscripten Setup**: Use `emconfigure` and `emmake` to build the core library.
2. **Wasm Module Creation**: Use `emcc` to link the static library into a Wasm module with the necessary exported functions.
3. **Table Management**: Bundle a restricted set of tables to minimize initial size.
    - **English**: `en-us-g1.ctb`, `en-us-g2.ctb`, `en-ueb-g1.ctb`, `en-ueb-g2.ctb`, `en-ueb-math.ctb`, `en-chardefs.cti`
    - **Spanish**: `es-g1.ctb`, `es-g2.ctb`, `Es-Es-G0.utb`, `es-chardefs.cti`
    - **Nemeth**: `nemethdefs.cti`, `en-us-mathtext.ctb`
    - **Hebrew**: `he-IL.utb`, `he-IL-comp8.utb`, `he-common-consonants.uti`, `he-common-vowels-ihbc.uti`
    - **Arabic**: `ar-ar-g1.utb`, `ar-ar-g2.ctb`, `ar-ar-g1-core.uti`, `ar-ar-math.uti`
    - **Hindi**: `hi-in-g1.utb`, `devanagari.cti`
    - **Tamil**: `ta-ta-g1.ctb`, `ta.ctb`, `tamil.cti`
    - **Common Dependencies**: `braille-patterns.cti`, `controlchars.cti`, `spaces.uti`, `digits6Dots.uti`, `digits8Dots.uti`, `latinLetterDef6Dots.uti`, `latinLetterDef8Dots.uti`, `latinLowercase.uti`, `latinUppercaseComp6.uti`, `eurodefs.cti`, `printables.cti`, `compress.cti`, `corrections.cti`

## Phase 3: Web Interface (UI/UX)
1. **HTML/JS Boilerplate**: A simple interface with:
    - Input text area.
    - Table selector (populated from the `tables/` directory).
    - Braille output display.
2. **Liblouis Wrapper**: A JavaScript class to wrap the Wasm calls for easier consumption.

## Phase 4: Build Automation
1. **Build Script**: Create a `build-wasm.sh` or similar to automate the compilation process.
2. **GitHub Actions**: (Optional) Configure a workflow to automate deployment to GitHub Pages.

## Phase 5: Deployment
1. **GitHub Pages**: Host the static assets (HTML, JS, Wasm, data) on a `gh-pages` branch.

---

## Technical Details

### Key Exported Functions
- `lou_version`
- `lou_translateString`
- `lou_backTranslateString`
- `lou_setDataPath` (crucial for finding tables)

### Challenges
- **Table Size**: The `tables/` directory contains hundreds of files. Preloading all might be heavy.
- **Memory Management**: Handling `widechar` (UTF-16 vs UTF-32) in JavaScript.
