# Lean4 Learning Log

A personal learning journal for [Lean4](https://lean-lang.org/) —
documenting the journey from Coq/Rocq and Haskell into Lean4's unified
world of programming and theorem proving.

## Structure

```
LeanLearning/       ← Lean source files (one per chapter)
notes/              ← Markdown notes and chapter overviews
```

Each chapter `.lean` file is heavily commented and contains inline exercises
marked with `sorry`. Open the file in VSCode and use the **Lean Infoview**
panel (`Ctrl+Shift+Enter`) to see live goal states.

## Setup

### 1. Install elan (Lean version manager)

```bash
curl -sSf https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
  | sh -s -- -y
source ~/.profile   # or open a new terminal
```

### 2. Install the VSCode extension

Install [vscode-lean4](https://marketplace.visualstudio.com/items?itemName=leanprover.lean4)
from the Extensions panel (`Ctrl+Shift+X`), search for **Lean 4**.

### 3. Build

```bash
lake build
```

The first build downloads the Lean toolchain (may take a few minutes).
Subsequent builds are fast.

## Chapters

| # | File | Topic |
|---|------|-------|
| 01 | `LeanLearning/Ch01_Basics.lean` | Expressions, functions, types, basic IO |
| 02 | `LeanLearning/Ch02_Types.lean` | Inductive types, pattern matching, structures |
| 03 | `LeanLearning/Ch03_TypeClasses.lean` | Type classes, instances, deriving |
| 04 | `LeanLearning/Ch04_Monads.lean` | Monads, do-notation, IO, Option, Except |
| 05 | `LeanLearning/Ch05_Proofs.lean` | First proofs: rfl, simp, exact, apply |
| 06 | `LeanLearning/Ch06_DependentTypes.lean` | Dependent types, Prop vs Type, Fin |

## Exercises

Exercises are inline `sorry` placeholders. Fill them in as you go.
`lake build` still succeeds with open `sorry`s (they produce warnings, not errors).
