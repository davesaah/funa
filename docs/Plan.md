# Working

- [x] Define types.
- [x] Define tokens.
- [x] Create lexer.
- [ ] Create parser.
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

- identifier: user defined functions, variables.
    - rule -> must begin with text + _ (opt) + number (opt, can only be at the end)

- `:` separating key in map.
- `.`: access functions from modules.
- `=`: assignment.
- `,`: separator for function arguments.
- `[]`: list literal grouping.
- `()`: function call grouping.
- `{}`: map literal grouping.


## Strategy For Parser

1. BNF Definition

2. Parsing Strategy

   - Recursive Descent: top-down approach, easy to debug and maintain, good for learning parser
    concepts, easy error recovery and reporting. The behaviour is predictive.

3. Parsing Logic Structure
4. Create Abstract Syntax Trees
5. Handle Any Errors

> **Recursive Descent** is a top-down parsing technique that uses a set of recursive functions to parse
> a language grammar.
> - It starts from the top-level grammar rule and works downward.
> - Each grammar rule is implemented as a separate function.
> - It is predictive in behaviour. It looks ahead in the inpute to determine which rule to apply.
> - Code and grammar is almost one-to-one.