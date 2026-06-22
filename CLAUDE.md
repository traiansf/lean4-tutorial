# Lean4 Learning Log — AI Assistant Instructions

This is a personal Lean4 learning log. The learner knows Coq/Rocq and Haskell well.

## Style and Content Guidelines

- **Always bridge to Coq/Haskell**: When introducing a Lean4 concept, compare it
  explicitly to its Coq/Rocq and/or Haskell equivalent.
- **Comments over docs**: Prefer inline `--` comments in `.lean` files over
  separate documentation. The code IS the tutorial.
- **Exercises as `sorry`**: Mark exercise gaps with `-- EXERCISE: fill in the sorry below`
  followed by a `sorry` on the definition body line.
- **No Mathlib** (yet): Keep dependencies minimal. Don't add Mathlib to `lakefile.toml`
  unless explicitly asked.
- **`lake build` must pass**: All `.lean` files must compile after any change.
  `sorry` produces warnings, not errors — that's expected.

## Project Layout

```
LeanLearning/       ← One .lean file per chapter
notes/              ← One .md overview per chapter
lakefile.toml       ← Lake build config (do not add deps without asking)
lean-toolchain      ← Lean version pin (do not change without asking)
```

## Running and Testing

```bash
# Build all chapters
lake build

# Check a single file (useful for quick iteration)
lean LeanLearning/Ch01_Basics.lean

# Clean build artifacts
lake clean
```

## Chapter Progression

PL-first (Ch01–04), then proofs (Ch05), then the unification of both (Ch06).
New chapters are added at the end as exploration continues.
