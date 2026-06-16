# LaTeX manuscript template

My own template for academic manuscripts with main document and supplementary materials, with support for cross-referencing between documents.

## Features

- **Two-document structure** - Main manuscript and supplementary materials
- **Cross-referencing** - Using `xr` package for references between documents
- **Modern build system** - Uses `just` task runner with grouped recipes
- **Standard academic structure** - Pre-organized sections and components
- **Development tools** - Integrated spell checking, grammar checking, and health checks
- **Modular preamble** - Separate `_preamble.tex` files for easy customization
- **Sans-serif font** - Source Sans Pro for modern, readable typography
- **Helper macros** - TODO markers and hide commands in `components/common/common.tex`

## Quick start

### 1. Clone the repo

```bash
git clone --depth=1 https://github.com/yiliu6240/latex-manuscript-template.git
```

### 2. Customize document metadata

**In `sections-main/_preamble.tex`:**

- Line 19: Replace `[MANUSCRIPT TITLE]`
- Lines 23-24: Replace `[FIRST AUTHOR]`, `[SECOND AUTHOR]`
- Lines 25-33: Update affiliations
- Line 33: Update contact emails

**In `sections-supp/_preamble.tex`:**

- Line 21: Replace `[MANUSCRIPT TITLE]`
- Lines 24-25: Replace author names
- Lines 26-34: Update affiliations
- Line 34: Update contact emails

Also clear the placeholder entries in `bib.bib` before adding your own references.

### 3. Test your environment and build

```bash
just checkhealth   # Check LaTeX and tool availability
just build         # Build all documents
```

Individual builds:

```bash
just build-main    # Main manuscript only
just build-supp    # Supplementary materials only
```

### 4. Edit content

Edit section files in:

- `sections-main/` for main manuscript
- `sections-supp/` for supplementary materials

## Cross-referencing between documents

The template uses the `xr` package for cross-referencing without prefixes.
Use the label name directly when referencing across documents.

### From main to supplementary

```latex
% In main manuscript sections
See Table~\ref{sec:supp-methods} in supplementary materials.
Additional details in Section~\ref{sec:supp-results}.
```

### From supplementary to main

```latex
% In supplementary sections
This extends Section~\ref{sec:methods} of the main manuscript.
Results support Figure~\ref{fig:main-result}.
```

### Label conventions

Main manuscript labels:

```latex
\label{sec:intro}           % Sections
\label{subsec:methods/data} % Subsections
\label{fig:main-result}     % Figures
\label{tab:summary}         % Tables
```

Supplementary labels:

```latex
\label{sec:supp-methods}        % Sections
\label{fig:supp-detailed}       % Figures
\label{tab:supp-full-data}      % Tables
```

## Project structure

```
your-manuscript/
|-- main-manuscript.tex          # Main document
|-- supplementary-materials.tex  # Supplementary document
|-- bib.bib                      # Bibliography
|-- justfile                     # Build system (task runner)
|-- _typos.toml                  # Typos spell checker configuration
|-- sections-main/               # Main manuscript sections
|   |-- _preamble.tex            # Main document preamble
|   |-- 00-abstract.tex
|   |-- 10-intro.tex
|   |-- 20-methods.tex
|   |-- 30-results.tex
|   |-- 40-discussion.tex
|   |-- 50-conclusion.tex
|   `-- 90-final.tex
|-- sections-supp/               # Supplementary sections
|   |-- _preamble.tex            # Supplementary preamble
|   |-- 10-methods.tex
|   |-- 20-results.tex
|   |-- 30-tables.tex
|   `-- 40-figures.tex
|-- assets/                      # Build tools and assets
|   |-- latexmkrc                # Build configuration
|   |-- texcount.pl              # Word counting
|   |-- latexpand                # File expansion
|   |-- checkhealth.sh           # Dependency checker
|   |-- data/                    # Data files
|   |-- figures/                 # Figure assets
|   |-- tables/                  # Table data
|   `-- arxiv/                   # arXiv style files
|-- components/                  # Reusable components
|   |-- common/                  # Common macros (todo, hide)
|   |-- figures/                 # Figure definitions
|   |-- tables/                  # Table definitions
|   `-- snippets/                # Text snippets
`-- docs/                        # Documentation
    `-- dict.txt                 # Custom dictionary for textidote
```

## Available just commands

```bash
just                        # List all commands
just build                  # Build all documents
just build-main             # Build main manuscript only
just build-supp             # Build supplementary materials only
just spell                  # Spell check with typos
just grammar-main           # Grammar check main manuscript with textidote
just grammar-supplementary  # Grammar check supplementary with textidote
just checkhealth            # Check all dependencies are installed
just count-main             # Count words in main manuscript
just clean                  # Clean build artifacts
```

## Development workflow

### Initial setup

1. Copy template
2. Customize metadata in preamble files
3. Run `just checkhealth` to verify dependencies

### Writing

1. Edit section files in `sections-main/` and `sections-supp/`
2. Add figures to `assets/figures/` and definitions to `components/figures/`
3. Add tables to `assets/tables/` and definitions to `components/tables/`
4. Use helper macros for TODOs and hidden text

### Checking

1. Run `just build` frequently to check compilation
2. Run `just spell` for spell checking
3. Run `just grammar-main` and `just grammar-supplementary` for grammar
4. Add false positives to `_typos.toml` or `docs/dict.txt`

### Before submission

1. Remove all `\hide{}` and `\todo{}` markers
2. Run `just build` twice for cross-references
3. Run `just count-main` for word count
4. Review output PDFs

## Development tools

### Spell checking with typos

```bash
just spell
```

Configuration in `_typos.toml`:

- Uses British English (en-gb)
- Ignores LaTeX commands and bibliography
- Custom word list for domain-specific terms

### Grammar checking with textidote

```bash
just grammar-main
just grammar-supplementary
```

Configuration:

- British English checks
- Custom dictionary in `docs/dict.txt`
- Ignores common LaTeX patterns

### Health checking

```bash
just checkhealth
```

Checks for:

- `latexmk` (required for building)
- `xelatex` (required for XeLaTeX compilation)
- `perl` (required for texcount)
- `chktex` (optional, for LaTeX linting)
- `typos` (optional, for spell checking)
- `textidote` (optional, for grammar checking)

## Requirements

### Required

```bash
# macOS with Homebrew
brew install texlive

# Ubuntu/Debian
sudo apt-get install texlive-full texlive-xetex

# Install just task runner
brew install just  # macOS
cargo install just # Cross-platform with Rust
```

### Optional development tools

```bash
# Spell checking
brew install typos-cli

# Grammar checking
brew install textidote

# LaTeX linting
brew install chktex
```

## Font configuration

The template uses Source Sans Pro for a modern, readable appearance.
Ensure the font is installed or modify `sections-main/_preamble.tex` and `sections-supp/_preamble.tex` to use different fonts.

```bash
# macOS
brew install --cask font-source-sans-pro
```

To switch to a different font, edit both preamble files:

```latex
% Replace these lines in sections-main/_preamble.tex and sections-supp/_preamble.tex
\usepackage{fontspec}
\usepackage[default]{sourcesanspro}

% With your preferred font, for example:
\usepackage{fontspec}
\setmainfont{Times New Roman}
```

## Customization

### Adding sections

1. Create new `.tex` files in `sections-main/` or `sections-supp/`
2. Add `\input{sections-main/your-section.tex}` to main documents
3. Follow numbering convention (e.g., `25-new-section.tex`)

### Adding figures and tables

1. Place assets in `assets/figures/` or `assets/tables/`
2. Create LaTeX definitions in `components/figures/` or `components/tables/`
3. Include in section files using `\input{components/figures/your-figure.tex}`

### Using helper macros

From `components/common/common.tex`:

```latex
% Hide text during drafting
\hide{This text will not appear in the output}

% Add TODO markers
\todo{Fix this section}
\todo[FIXME]{Revise argument}
\TODO  % Simple TODO marker
```

### Changing document style

- Modify preamble sections in `sections-main/_preamble.tex` and `sections-supp/_preamble.tex`
- Update `assets/arxiv/arxiv.sty` for style customizations
- Adjust `assets/latexmkrc` for build configurations

### Custom spell-check terms

Edit `_typos.toml` to add project-specific terms:

```toml
[default.extend-words]
yourterm = "yourterm"
YourTerm = "YourTerm"
```

### Custom grammar dictionary terms

Add words to `docs/dict.txt` (one per line) to extend the textidote dictionary:

```
yourterm
YourTerm
```

## Output files

After a successful build:

- `main-manuscript.pdf` - Main manuscript
- `supplementary-materials.pdf` - Supplementary materials

## Troubleshooting

### Build fails

```bash
just checkhealth   # Check dependencies
just clean         # Clean and retry
just build
```

Check for LaTeX syntax errors in section files.

### Cross-references not working

```bash
# Run build twice to resolve cross-references
just build
just build
```

Verify label names match between documents.

### Font not found

```bash
# Install Source Sans Pro or modify preamble files
brew install --cask font-source-sans-pro
```

### Spell-check false positives

Add terms to `_typos.toml` under `[default.extend-words]`.

### Grammar-check false positives

Add words to `docs/dict.txt`. Check `justfile` for the ignored textidote rules.
