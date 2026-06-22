# Chapter 4: Monads and IO

## Goals
- Use `do`-notation for sequencing IO actions.
- Work with `Option` (≈ `Maybe`) for optional values.
- Work with `Except` (≈ `Either`) for error handling.
- Understand `Functor`, `Applicative`, `Monad` in Lean4.

## Key Concepts

| Lean4 | Haskell | Notes |
|-------|---------|-------|
| `IO α` | `IO a` | Main effect type |
| `Option α` | `Maybe a` | Optional values |
| `some x` / `none` | `Just x` / `Nothing` | |
| `Except ε α` | `Either ε a` | Error handling |
| `Except.ok x` / `Except.error e` | `Right x` / `Left e` | |
| `IO.println` | `putStrLn` | |
| `IO.getLine` | `getLine` | |
| `return x` | `return x` / `pure x` | Lift value into monad |

## Next
→ [Chapter 5: First Proofs](Ch05_Proofs.md)
