# Default recipe
default:
    @just --list --unsorted

# ==== Build ====

# Build all documents
[group('build')]
build: build-main build-supp

# Build main manuscript only
[group('build')]
build-main:
    latexmk -r latexmkrc --xelatex main-manuscript

# Build supplementary materials only
[group('build')]
build-supp:
    latexmk -r latexmkrc --xelatex supplementary-materials

# ==== Development ====

# ---- textidote flags ----
textidote_flags := "\
    --check en_UK \
    --ignore sh:seclen,sh:nsubdiv,sh:nomark,sh:figref,sh:d:002,lt:en:MORFOLOGIK_RULE_EN_GB,lt:en:OXFORD_SPELLING_Z_NOT_S,lt:en:EN_REPEATEDWORDS \
    --dict docs/dict.txt \
    "

# Spell check with typos
[group('development')]
spell:
    typos .

# Grammar check manuscript with textidote, main manuscript
[group('development')]
grammar-main:
    textidote {{ textidote_flags }} main-manuscript.tex

# Grammar check manuscript with textidote, supplementary
[group('development')]
grammar-supplementary:
    textidote {{ textidote_flags }} supplementary-materials.tex

# ==== Utilities ====

# Check that all dependencies are installed
[group('utilities')]
checkhealth:
    bash assets/checkhealth.sh

# Count words using texcount for main manuscript
[group('utilities')]
count-main:
    perl assets/texcount.pl -dir . -inc main-manuscript.tex

# Clean build artefacts and remove all files including PDFs
[group('utilities')]
clean:
    latexmk -C
