# language-groovy

Groovy language support.

## Features

- **Grammars**: provides Tree-sitter grammars, built from [tree-sitter-groovy](https://github.com/murtaza64/tree-sitter-groovy).
- **Syntax highlighting**: full tree-sitter grammar coverage for Groovy files.
- **Folding**: folds blocks from the parse tree rather than by indentation.

## Installation

To install `language-groovy` search for it in the Install pane of the Lumine settings, or run the command `lumine --install lumine-code/language-groovy`.

## Services

- `hyperlink.injection`: consumed to highlight URLs inside Groovy files as clickable links.
- `todo.injection`: consumed to highlight `TODO`-style markers inside comments.

## Contributing

Got ideas to make this package better, found a bug, or want to help add new features? Just drop your thoughts on GitHub. Any feedback is welcome!
