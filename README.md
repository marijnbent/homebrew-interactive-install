# brew-interactive

https://github.com/user-attachments/assets/94360b1c-ec6e-4524-a222-b8e49efb56ef

## Description

This script provides an enhanced, interactive command-line interface for managing Homebrew packages (formulae and casks). It streamlines the common workflow of searching for a package, viewing its information, and then installing it. Instead of typing multiple `brew` commands, you can:

1. Search for packages using a fuzzy finder (`fzf`).
2. Instantly preview `brew info` for the highlighted package within `fzf`.
3. Select a package (press Enter) to directly install it.
4. After an install attempt, you are immediately presented with options to:
    * Re-run the same search (refresh results).
    * Start a new search for a different package.
    * Quit the interactive session.

This tool is ideal for users who frequently explore and install new Homebrew packages and prefer a more dynamic keyboard-driven experience. It leverages `fzf` for its powerful fuzzy searching and preview capabilities.

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
