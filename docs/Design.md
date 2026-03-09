# Design

## Purpose

- **Target domain:** automation on unix systems.
- **Paradigm:** functional.
- **Abstractions:** GNU shell utils.
- **Constraints:** compiled binary, portability.

## Core Concepts

- **Types:** file, string, number, map, list.
- **Functions:** composable, first-class, higher-order.
- **Side-effects:** GNU tools, reading files, spawning processes.
- **Control flow:** Pattern matching, recursion.
- **Modules:** specify which tools to use.

## Syntax

## Grammar

## Compiler Architecture

1. Translates AST 
2. Intermediate representation
3. Binary

## Runtime & Memory Module

- Executes function pipelines.
- Needs to manage:
    - Lazy evaluation.
    - External command processes.
    - Function composition.
    - Module loading.
    - Errors.

## Module & Extensibility System

- Core: gnu tools
- Module should include:
    - Only what user imports
    - Map module functions to implementations (gnu util commands)

## Error Handling & Type Safety

- Compile-time checking.
- Functional-style error propagation (e.g. `Result<T, Error>` stream)

