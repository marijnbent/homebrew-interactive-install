# Brew Interactive Install

`brew search`, `brew info` and `brew install` combined in `brewi`.

https://github.com/user-attachments/assets/94360b1c-ec6e-4524-a222-b8e49efb56ef

## Description

This script provides an enhanced, interactive command-line interface for managing Homebrew packages (formulae and casks). It streamlines the common workflow of searching for a package, viewing its information, and then installing it. `brewi` replaces `brew search`, `brew info` and `brew install`.

1. Search for packages
2. Immediately see the package info
3. Install with `Enter`
4. After an install attempt, you are presented with options to:
    * Re-run the same search.
    * Start a new search for a different package.
    * Quit the script.

## Installation and Setup

```bash
brew tap marijnbent/homebrew-interactive-install
brew install brewi
```

## Usage

Once installed and (optionally) in your PATH or aliased:

* To start with an initial search term:
```bash
brewi <search_term>
```
Example:
```bash
brewi httpie
```

**Inside the script:**
* Use arrow keys (↑↓) to navigate the search results in `fzf`.
* The right pane will show `brew info` for the highlighted package.
* Press `Enter` on a package in the list to *directly install it*.
