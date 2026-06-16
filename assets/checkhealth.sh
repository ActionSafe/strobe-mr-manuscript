#!/usr/bin/env bash
set -euo pipefail
echo "Checking dependencies..."
echo ""
# ---- latexmk ----
if command -v latexmk &> /dev/null; then
    echo "[OK] latexmk: $(latexmk --version | head -n 1)"
else
    echo "[MISSING] latexmk"
fi
# ---- xelatex ----
if command -v xelatex &> /dev/null; then
    echo "[OK] xelatex: $(xelatex --version | head -n 1)"
else
    echo "[MISSING] xelatex"
fi
# ---- perl ----
if command -v perl &> /dev/null; then
    echo "[OK] perl: $(perl --version | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+')"
else
    echo "[MISSING] perl (required for texcount)"
fi
# ---- chktex ----
if command -v chktex &> /dev/null; then
    echo "[OK] chktex: $(chktex --version 2>&1 | head -n 1)"
else
    echo "[MISSING] chktex (install with: brew install chktex)"
fi
# ---- typos ----
if command -v typos &> /dev/null; then
    echo "[OK] typos: $(typos --version)"
else
    echo "[MISSING] typos (install with: brew install typos-cli)"
fi
# ---- textidote ----
if command -v textidote &> /dev/null; then
    echo "[OK] textidote: $(textidote --version 2>&1 | head -n 1)"
else
    echo "[MISSING] textidote (install with: brew install textidote)"
fi
echo ""
echo "Checkhealth complete."
