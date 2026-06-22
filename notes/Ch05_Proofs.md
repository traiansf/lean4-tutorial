# Chapter 5: First Proofs

## Goals
- Write `theorem` declarations.
- Use basic tactics: `rfl`, `simp`, `omega`, `exact`, `apply`.
- Understand the tactic goal state in the Lean Infoview.
- Prove simple arithmetic and logical propositions.

## Key Concepts

| Lean4 tactic | Coq tactic | What it does |
|-------------|-----------|--------------|
| `rfl` | `reflexivity` | Prove `a = a` |
| `simp` | `simp` / `ring` | Apply rewrite rules |
| `omega` | `omega` / `lia` | Linear arithmetic |
| `exact h` | `exact h` | Provide proof term directly |
| `apply f` | `apply f` | Apply a lemma |
| `intro h` | `intro h` | Introduce hypothesis |
| `cases h` | `destruct h` | Case split |

## Next
→ [Chapter 6: Dependent Types](Ch06_DependentTypes.md)
