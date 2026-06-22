# Chapter 1: Basics

## Goals

- Get comfortable with `#eval` and `#check` as the REPL.
- Write functions with `def` and understand Lean4's syntax.
- Understand the basic type hierarchy.
- Write your first IO program with `do`-notation.

## Key Concepts

| Lean4 | Haskell equivalent | Coq equivalent |
|-------|-------------------|----------------|
| `#eval e` | GHCi: type `e` | `Compute e.` |
| `#check e` | GHCi: `:t e` | `Check e.` |
| `def f (x : T) : U := ...` | `f :: T -> U; f x = ...` | `Definition f (x : T) : U := ...` |
| `fun x => e` | `\x -> e` | `fun x => e` |
| `let x := e` | `let x = e in ...` | `let x := e in ...` |
| `if b then t else f` | `if b then t else f` | `if b then t else f` |
| `IO Unit` | `IO ()` | N/A (Coq is pure) |
| `s!"Hello {name}"` | no built-in (use `printf`) | N/A |

## Gotchas

- **Saturating `Nat` subtraction**: `(5 : Nat) - 8 = 0`. If you need
  negative results, use `Int`.
- **Bool literals are lowercase**: `true`, `false` (not `True`, `False`
  like Haskell).
- **No `in` after `let`**: Indentation scopes the binding (Lean4's layout rule).
- **`do` requires `IO` or another monad**: Bare `do` is not valid at the top level.

## Exercises

See `Ch01_Basics.lean` — fill in the `sorry` placeholders:
1. `square` — squaring a Nat
2. `max'` — maximum of two Nats
3. `greet` — IO action printing a greeting
4. Saturating subtraction observation

## Next

→ [Chapter 2: Types](Ch02_Types.md) — `inductive`, pattern matching, `structure`
