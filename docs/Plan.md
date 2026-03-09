# Working

- [x] Define types.
- [x] Define tokens.
- [ ] Create lexer.
- [ ] Define syntax.
- [ ] Define grammar.
- [ ] Build lexer.
- [ ] Build parser.
- [ ] Implement abstract syntax tree.

## Types

- number.
- list.
- map.
- string.
- file.

## Tokens

- using: import a module.
- let: define a new function.
- main: entry point of the program.
- return: return value from a function.

- `=>`: pattern matching/branch selection.
- `_`: wildcard match.
- `|`: pattern separator.
- `;`: statement terminator.
- `#`: comments

- number: numeric type. int/float
- list: ordered collection. [1,2,3]/["some", "one"]
- map: key-value collection. {"key": "value"}
- string: string type. `"`/`'`
- file: file type.

- identifier: user defined functions, variables.
    - rule -> must begin with text + _ (opt) + number (opt, can only be at the end)

- `:` separating key in map.
- `.`: access functions from modules.
- `=`: assignment.
- `,`: separator for function arguments.
- `[]`: list literal grouping.
- `()`: function call grouping.
- `{}`: map literal grouping.
