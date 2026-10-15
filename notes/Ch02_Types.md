# Chapter 2: Types

## Goals
- Define algebraic data types with `inductive`.
- Write exhaustive pattern matches with `match`.
- Define record types with `structure`.

## Key Concepts

| Lean4 | Haskell | Coq |
|-------|---------|-----|
| `inductive T where \| A \| B` | `data T = A \| B` | `Inductive T := A \| B.` |
| `match x with \| A => ... \| B => ...` | `case x of A -> ...; B -> ...` | `match x with \| A => ... \| B => ...` |
| `structure S where f : T` | `data S = S { f :: T }` | `Record S := { f : T }` |
| `{ s with f := v }` | `s { f = v }` | no built-in update; use record construction spelling out all fields |

## Gotchas
- Constructors are namespaced: `Color.red`, not just `red` (unless opened).
- `deriving Repr` is needed for `#eval` to display custom types.
- Structures have exactly one constructor (the record itself).

## Next
→ [Chapter 3: Type Classes](Ch03_TypeClasses.md)
