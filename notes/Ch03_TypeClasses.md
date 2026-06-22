# Chapter 3: Type Classes

## Goals
- Define type classes with `class`.
- Implement instances with `instance`.
- Use `deriving` for auto-generated instances.
- Write polymorphic functions with type class constraints.

## Key Concepts

| Lean4 | Haskell | Coq |
|-------|---------|-----|
| `class C (α : Type) where m : α → T` | `class C a where m :: a -> T` | `Class C (α : Type) := { m : α → T }` |
| `instance : C T where m := ...` | `instance C T where m = ...` | `Instance : C T := { m := ... }` |
| `[C α]` constraint | `C a =>` constraint | `{c : C α}` implicit |
| `deriving BEq, Repr` | `deriving Eq, Show` | manual instances |

## Next
→ [Chapter 4: Monads & IO](Ch04_Monads.md)
