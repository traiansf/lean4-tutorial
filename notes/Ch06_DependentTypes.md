# Chapter 6: Dependent Types

## Goals
- Understand the difference between `Prop` and `Type`.
- Use `Fin n` for bounded, safe indexing.
- Encode invariants in types (proof-carrying data).
- See where the programming and proving sides of Lean4 meet.

## Key Concepts

| Concept | Lean4 | Coq | Haskell |
|---------|-------|-----|---------|
| Dependent function | `(n : Nat) → Vec α n` | `forall n, Vec α n` | GADTs (limited) |
| Bounded Nat | `Fin n` | `Fin n` | `Data.Fin` (non-std) |
| Proof universe | `Prop` | `Prop` | N/A |
| Data universe | `Type` | `Type` | `Type` (all) |
| Proof in data | `{ val : T // P val }` | `{ x : T | P x }` | N/A |

## The Big Picture

Lean4's key insight: **propositions are types, proofs are programs**.
- `1 + 1 = 2` is a type; `rfl` is a value of that type.
- A function `f : (n : Nat) → Fin n → α` is a program that's
  *provably safe* — the type system rules out out-of-bounds access.
