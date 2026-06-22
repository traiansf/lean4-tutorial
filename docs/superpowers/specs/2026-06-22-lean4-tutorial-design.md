# Lean4 Learning Log — Design Spec

**Date:** 2026-06-22
**Author:** traian.serbanuta@gmail.com

## Purpose

A personal learning log for Lean4 — a public, maintainable repo that
documents one experienced developer's journey through the language. The
learner knows Coq/Rocq and Haskell well; the tutorial explicitly bridges
from those languages to Lean4 concepts throughout.

Primary focus: Lean4 as a programming language (B), with progressive
introduction of its proof side and the unification of the two (C).

## Repository Structure

```
lean4/                         ← git root
├── README.md                  ← public overview and setup instructions
├── CLAUDE.md                  ← AI assistant instructions for this repo
├── lakefile.toml              ← Lake build config (package: LeanLearning)
├── lean-toolchain             ← pins Lean version via elan
├── .gitignore                 ← excludes .lake/, lake-packages/
├── LeanLearning/
│   ├── Ch01_Basics.lean
│   ├── Ch02_Types.lean
│   ├── Ch03_TypeClasses.lean
│   ├── Ch04_Monads.lean
│   ├── Ch05_Proofs.lean
│   └── Ch06_DependentTypes.lean
└── notes/
    ├── Ch01_Basics.md
    ├── Ch02_Types.md
    ├── Ch03_TypeClasses.md
    ├── Ch04_Monads.md
    ├── Ch05_Proofs.md
    └── Ch06_DependentTypes.md
```

## Content Format

- **`.lean` files** — heavily commented; the narrative lives in the code.
  Exercises are inline `sorry`-gaps marked with `-- EXERCISE: fill in the sorry below`.
- **`.md` files** — chapter overview, goals, key takeaways, and
  cross-references to Coq/Haskell equivalents.
- **Bridging** — every chapter explicitly connects Lean4 constructs to
  their Coq/Rocq and Haskell analogues.

## Chapter Plan

| Chapter | File | Topic | Key concepts |
|---------|------|--------|--------------|
| 01 | `Ch01_Basics.lean` | Basics | `#eval`, `def`, `let`, `do`, primitive types |
| 02 | `Ch02_Types.lean` | Types | `inductive`, pattern matching, `structure` |
| 03 | `Ch03_TypeClasses.lean` | Type Classes | `class`, `instance`, `deriving` |
| 04 | `Ch04_Monads.lean` | Monads & IO | `do`-notation, `IO`, `Option`, `Except` |
| 05 | `Ch05_Proofs.lean` | First Proofs | `theorem`, `rfl`, `simp`, `exact`, `apply` |
| 06 | `Ch06_DependentTypes.lean` | Dependent Types | `Fin`, proof-carrying types, `Prop` vs `Type` |

Chapters are loosely ordered but the log is living — new chapters are
added as exploration continues, and chapters can be revisited.

## Tooling

| Tool | Purpose |
|------|---------|
| **elan** | Lean version manager (install/switch toolchains) |
| **Lake** | Build system and package manager (bundled with elan) |
| **VSCode** | Primary IDE (already installed) |
| **leanprover.lean4** | Official VSCode extension — infoview, inline errors, tactic completion |
| **Git** | Version control; repo lives in `/home/traian/lean4/` |

**Mathlib:** not included initially. Added in a later chapter when
real math or advanced tactics are needed.

**Key interaction loop:** VSCode's Lean Infoview panel shows live tactic
goal states — this is the primary feedback mechanism when working through
proofs and `sorry`-gap exercises.

## Setup Steps (to be implemented)

1. Install elan (Lean version manager) via shell script.
2. Initialize git repo in `/home/traian/lean4/`.
3. Create `lean-toolchain`, `.gitignore`, `README.md`, `CLAUDE.md`.
4. Run `lake init LeanLearning` (or create `lakefile.toml` manually).
5. Install VSCode extension `leanprover.lean4`.
6. Create chapter skeleton files (`.lean` + `.md`) with stub content.
7. Verify build with `lake build`.
8. Make initial commit.

## Success Criteria

- `lake build` passes with no errors on all chapter files (with `sorry`s).
- VSCode infoview shows live goal state when cursor is inside a `sorry`.
- README explains setup so the repo is usable by others.
- Chapter 1 is fully written and interactive session can begin.
