# Lean4 Learning Log Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Set up a fully working Lean4 learning-log repo with elan/Lake tooling, VSCode integration, and a fully-written Chapter 1 plus skeleton chapters 2–6.

**Architecture:** Single Lake package (`LeanLearning`) containing one `.lean` file per chapter. A root `LeanLearning.lean` imports all chapters so `lake build` compiles everything. Each chapter has a parallel `notes/ChNN_*.md` overview. Chapters bridge from Coq/Rocq and Haskell to Lean4 concepts throughout.

**Tech Stack:** Lean4 (via elan), Lake (bundled with elan), VSCode with `leanprover.lean4` extension, Git.

## Global Constraints

- All files live under `/home/traian/lean4/` (the git root and working directory).
- Lean version is pinned via `lean-toolchain` file; use `leanprover/lean4:stable`.
- Lake package name: `LeanLearning`. Source root: `LeanLearning/`.
- `lake build` must pass with zero errors (sorry-gaps produce warnings, not errors).
- Every `.lean` chapter file must have explicit Coq/Haskell bridging comments.
- Exercise gaps are marked with `-- EXERCISE: fill in the sorry below`.

---

### Task 1: Install elan and verify Lean toolchain

**Files:**
- No repo files yet — system-level install only.

- [ ] **Step 1: Install elan via the official shell script**

```bash
curl -sSf https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
  | sh -s -- -y --no-modify-path
```

Expected output ends with: `elan: Lean toolchain manager installed`

- [ ] **Step 2: Add elan to PATH for this session**

```bash
export PATH="$HOME/.elan/bin:$PATH"
```

(The installer adds `~/.elan/bin` to `~/.profile` for future sessions.)

- [ ] **Step 3: Verify elan and lean are available**

```bash
elan --version
lean --version
lake --version
```

Expected: version strings for all three tools (e.g., `elan 3.x.x`, `Lean 4.x.x`, `Lake 4.x.x`).

- [ ] **Step 4: Install the stable Lean4 toolchain (if not auto-installed)**

```bash
elan toolchain install leanprover/lean4:stable
elan default leanprover/lean4:stable
```

---

### Task 2: Initialize git repo and project scaffold

**Files:**
- Create: `/home/traian/lean4/.git/` (via `git init`)
- Create: `/home/traian/lean4/lean-toolchain`
- Create: `/home/traian/lean4/.gitignore`
- Create: `/home/traian/lean4/lakefile.toml`
- Create: `/home/traian/lean4/LeanLearning.lean`

- [ ] **Step 1: Initialize git repository**

```bash
cd /home/traian/lean4
git init
```

Expected: `Initialized empty Git repository in /home/traian/lean4/.git/`

- [ ] **Step 2: Create `lean-toolchain`**

Contents of `/home/traian/lean4/lean-toolchain`:
```
leanprover/lean4:stable
```

This pins the Lean version; elan reads it automatically when you `cd` into the directory.

- [ ] **Step 3: Create `.gitignore`**

Contents of `/home/traian/lean4/.gitignore`:
```
# Lake build artifacts
.lake/
lake-packages/

# Editor
.vscode/settings.json
*.swp
*~
```

- [ ] **Step 4: Create `lakefile.toml`**

Contents of `/home/traian/lean4/lakefile.toml`:
```toml
name = "LeanLearning"
version = "0.1.0"
defaultTargets = ["LeanLearning"]

[[lean_lib]]
name = "LeanLearning"
```

- [ ] **Step 5: Create root `LeanLearning.lean` that imports all chapters**

Contents of `/home/traian/lean4/LeanLearning.lean`:
```lean
-- Root module: importing this compiles all chapters.
import LeanLearning.Ch01_Basics
import LeanLearning.Ch02_Types
import LeanLearning.Ch03_TypeClasses
import LeanLearning.Ch04_Monads
import LeanLearning.Ch05_Proofs
import LeanLearning.Ch06_DependentTypes
```

- [ ] **Step 6: Create `LeanLearning/` directory**

```bash
mkdir -p /home/traian/lean4/LeanLearning
mkdir -p /home/traian/lean4/notes
```

---

### Task 3: Create README.md and CLAUDE.md

**Files:**
- Create: `/home/traian/lean4/README.md`
- Create: `/home/traian/lean4/CLAUDE.md`

- [ ] **Step 1: Create `README.md`**

Contents of `/home/traian/lean4/README.md`:
```markdown
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
```

- [ ] **Step 2: Create `CLAUDE.md`**

Contents of `/home/traian/lean4/CLAUDE.md`:
```markdown
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
```

---

### Task 4: Install VSCode extension

**Files:** No repo files — VSCode system config only.

- [ ] **Step 1: Install the leanprover.lean4 extension**

```bash
code --install-extension leanprover.lean4
```

Expected output: `Extension 'leanprover.lean4' v...  was successfully installed.`

- [ ] **Step 2: Verify it shows up**

```bash
code --list-extensions | grep lean
```

Expected: `leanprover.lean4`

- [ ] **Step 3: (Manual) Open the repo in VSCode and confirm Infoview loads**

```bash
code /home/traian/lean4
```

Open `LeanLearning/Ch01_Basics.lean`. Press `Ctrl+Shift+Enter` to open the
Lean Infoview. Place cursor on a `sorry` — the expected type should appear
in the Infoview panel. If it says "Loading..." for more than 60 seconds,
check the extension output panel (`View → Output → Lean4`).

---

### Task 5: Write Chapter 1 — Basics

**Files:**
- Create: `/home/traian/lean4/LeanLearning/Ch01_Basics.lean`
- Create: `/home/traian/lean4/notes/Ch01_Basics.md`

- [ ] **Step 1: Create `LeanLearning/Ch01_Basics.lean`**

Contents of `/home/traian/lean4/LeanLearning/Ch01_Basics.lean`:
```lean
/-
  Chapter 1: Basics
  =================
  Lean4 as a programming language — first contact.

  If you know Haskell: Lean4's syntax is very similar. Key differences:
    - No lazy evaluation (strict by default, lazy via `Thunk`/`LazyList`)
    - `def` instead of top-level bindings without a keyword
    - `Nat` subtraction is saturating (10 - 20 = 0), not wrapping
    - Universe levels are explicit when needed (`Type 0`, `Type 1`, ...)

  If you know Coq: The proof side will feel familiar later.
  The functional programming side is closer to Haskell than Gallina.
    - `def` ≈ `Definition`
    - `#eval` ≈ `Compute`
    - `#check` ≈ `Check`
    - `fun x => ...` ≈ `fun x => ...` (same!)
-/

-- ─────────────────────────────────────────────────────────────────────────────
-- 1.1  Evaluating Expressions
-- ─────────────────────────────────────────────────────────────────────────────
-- `#eval` evaluates an expression and prints the result.
-- In Haskell: type in GHCi. In Coq: `Compute`.

#eval 1 + 1           -- 2
#eval "Hello, Lean4!" -- "Hello, Lean4!"
#eval [1, 2, 3]       -- [1, 2, 3]
#eval (10 : Nat) - 3  -- 7

-- ─────────────────────────────────────────────────────────────────────────────
-- 1.2  Defining Functions
-- ─────────────────────────────────────────────────────────────────────────────
-- `def` introduces a definition. In Haskell: top-level binding.
-- In Coq: `Definition`.

def double (n : Nat) : Nat := n * 2

#eval double 5   -- 10

-- Functions are curried (like Haskell):
def add (x y : Nat) : Nat := x + y

#eval add 3 4   -- 7
#eval (add 3)   -- a partially-applied function (type: Nat → Nat)

-- Anonymous functions use `fun` (same keyword as Coq; `\` in Haskell):
#eval (fun x => x + 1) 10   -- 11

-- Type signatures are part of `def`, not separate:
-- Haskell: double :: Int -> Int
--          double n = n * 2
-- Lean4:   def double (n : Nat) : Nat := n * 2

-- ─────────────────────────────────────────────────────────────────────────────
-- 1.3  Let Bindings
-- ─────────────────────────────────────────────────────────────────────────────
-- `let` introduces a local binding. In Haskell: `let ... in ...`.
-- In Coq: `let ... := ... in ...`.

def circleArea (r : Float) : Float :=
  let pi : Float := 3.14159265
  pi * r * r

#eval circleArea 5.0   -- 78.53981...

-- Note: `let` in Lean4 does NOT require an `in` keyword — indentation handles
-- scoping (like Haskell's layout rule, but simpler).

-- ─────────────────────────────────────────────────────────────────────────────
-- 1.4  Basic Types
-- ─────────────────────────────────────────────────────────────────────────────
-- Lean4's built-in types (all strict, unlike Haskell's lazy wrappers):
--
--   Nat    : natural numbers (0, 1, 2, ...) — arbitrary precision
--   Int    : integers (..., -1, 0, 1, ...)
--   Float  : 64-bit IEEE 754 float
--   Bool   : true / false  (lowercase in Lean4, unlike Haskell's True/False)
--   Char   : Unicode scalar value
--   String : UTF-8 string
--   Unit   : the unit type — its only value is `()`

-- `#check` shows the type of an expression. In Coq: `Check`.
#check (42 : Nat)    -- Nat
#check (42 : Int)    -- Int
#check 3.14          -- Float
#check 'A'           -- Char
#check "hello"       -- String
#check true          -- Bool
#check ()            -- Unit

-- ⚠️  GOTCHA: Nat subtraction is *saturating* (never goes below 0):
#eval (10 : Nat) - 20   -- 0  (not -10!)
-- Use Int if you need negative results:
#eval (10 : Int) - 20   -- -10

-- ─────────────────────────────────────────────────────────────────────────────
-- 1.5  If-Then-Else
-- ─────────────────────────────────────────────────────────────────────────────
-- `if` is an expression (like Haskell, unlike most imperative languages):

def abs' (n : Int) : Int :=
  if n < 0 then -n else n

#eval abs' (-5)   -- 5
#eval abs' 3      -- 3

-- ─────────────────────────────────────────────────────────────────────────────
-- 1.6  String Interpolation
-- ─────────────────────────────────────────────────────────────────────────────
-- Lean4 has `s!"..."` for string interpolation (Python f-strings analogue):

def greetMessage (name : String) : String :=
  s!"Hello, {name}! Welcome to Lean4."

#eval greetMessage "world"   -- "Hello, world! Welcome to Lean4."

-- ─────────────────────────────────────────────────────────────────────────────
-- 1.7  Basic IO with `do`-notation
-- ─────────────────────────────────────────────────────────────────────────────
-- `do`-notation sequences IO actions — exactly like Haskell's `do`.
-- In Coq, you'd use monadic bind manually (no `do` sugar by default).
-- `IO Unit` ≈ Haskell's `IO ()`

def hello : IO Unit := do
  IO.println "Hello from Lean4!"
  IO.println "This is the IO monad — just like Haskell."

#eval hello
-- Hello from Lean4!
-- This is the IO monad — just like Haskell.

-- `<-` extracts a value from IO, just like Haskell:
def askAndGreet : IO Unit := do
  IO.print "Enter your name: "
  let name ← IO.getLine
  IO.println s!"Hello, {name}!"

-- The program's entry point:
def main : IO Unit := do
  IO.println "Learning Lean4 — starting with basics."

-- ─────────────────────────────────────────────────────────────────────────────
-- EXERCISES
-- ─────────────────────────────────────────────────────────────────────────────
-- Fill in each `sorry`. The Lean Infoview shows the expected type when your
-- cursor is on or just after the `sorry`.

-- EXERCISE 1.1: Define `square` that returns n².
def square (n : Nat) : Nat := sorry

-- EXERCISE 1.2: Define `max'` returning the larger of two Nat values.
-- Hint: use `if ... then ... else ...`
def max' (a b : Nat) : Nat := sorry

-- EXERCISE 1.3: Define `greet` that performs IO, printing "Hello, <name>!"
def greet (name : String) : IO Unit := sorry

-- EXERCISE 1.4: What does `(5 : Nat) - 8` evaluate to? Why?
-- Write your answer as a comment, then verify with #eval.
-- ANSWER:

-- Verify your answers (these will show warnings until sorry is filled):
#eval square 6       -- should be 36
#eval max' 3 7       -- should be 7
#eval max' 9 2       -- should be 9
#eval greet "Lean4"  -- should print: Hello, Lean4!
```

- [ ] **Step 2: Create `notes/Ch01_Basics.md`**

Contents of `/home/traian/lean4/notes/Ch01_Basics.md`:
```markdown
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
```

---

### Task 6: Create skeleton chapters 2–6

**Files:**
- Create: `LeanLearning/Ch02_Types.lean`
- Create: `LeanLearning/Ch03_TypeClasses.lean`
- Create: `LeanLearning/Ch04_Monads.lean`
- Create: `LeanLearning/Ch05_Proofs.lean`
- Create: `LeanLearning/Ch06_DependentTypes.lean`
- Create: `notes/Ch02_Types.md`
- Create: `notes/Ch03_TypeClasses.md`
- Create: `notes/Ch04_Monads.md`
- Create: `notes/Ch05_Proofs.md`
- Create: `notes/Ch06_DependentTypes.md`

- [ ] **Step 1: Create `LeanLearning/Ch02_Types.lean`**

Contents:
```lean
/-
  Chapter 2: Types
  ================
  Algebraic data types, pattern matching, and structures.

  If you know Haskell: `inductive` ≈ `data`. Pattern matching is `match`.
  If you know Coq: `inductive` is nearly identical to Coq's `Inductive`.
  The big difference: Lean4 constructors don't need explicit type annotations
  in simple cases (they're inferred).
-/

-- ─────────────────────────────────────────────────────────────────────────────
-- 2.1  Inductive Types
-- ─────────────────────────────────────────────────────────────────────────────
-- `inductive` defines an algebraic data type.
-- In Haskell: `data`. In Coq: `Inductive`.

inductive Color where
  | red   : Color
  | green : Color
  | blue  : Color
deriving Repr  -- enables #eval to display values

#eval Color.red   -- Color.red

-- Parameterized types (like Haskell's `Maybe`, Coq's `option`):
inductive MyOption (α : Type) where
  | none : MyOption α
  | some : α → MyOption α
deriving Repr

#eval MyOption.some 42   -- MyOption.some 42
#eval (MyOption.none : MyOption Nat)   -- MyOption.none

-- Lean4's standard library already has `Option` (same as `Maybe` in Haskell):
#eval (some 42 : Option Nat)   -- some 42
#eval (none : Option Nat)      -- none

-- ─────────────────────────────────────────────────────────────────────────────
-- 2.2  Pattern Matching
-- ─────────────────────────────────────────────────────────────────────────────
-- `match` is exhaustive and checked by the compiler.
-- In Haskell: `case ... of`. In Coq: `match ... with`.

def colorName (c : Color) : String :=
  match c with
  | Color.red   => "red"
  | Color.green => "green"
  | Color.blue  => "blue"

#eval colorName Color.green   -- "green"

-- Pattern matching in function arguments (like Haskell):
def isNone : Option α → Bool
  | none   => true
  | some _ => false

-- ─────────────────────────────────────────────────────────────────────────────
-- 2.3  Recursive Types (Natural Numbers from scratch)
-- ─────────────────────────────────────────────────────────────────────────────
-- Lean4's `Nat` is literally defined as:
--   inductive Nat where | zero | succ (n : Nat)
-- Let's define our own to see how it works.

inductive MyNat where
  | zero : MyNat
  | succ : MyNat → MyNat
deriving Repr

def myNatToNat : MyNat → Nat
  | MyNat.zero   => 0
  | MyNat.succ n => myNatToNat n + 1

-- ─────────────────────────────────────────────────────────────────────────────
-- 2.4  Structures (Record Types)
-- ─────────────────────────────────────────────────────────────────────────────
-- `structure` defines a record type (product type with named fields).
-- In Haskell: `data` with record syntax. In Coq: `Record`.

structure Point where
  x : Float
  y : Float
deriving Repr

def origin : Point := { x := 0.0, y := 0.0 }
def p1 : Point := { x := 3.0, y := 4.0 }

-- Field access with dot notation:
#eval p1.x   -- 3.0
#eval p1.y   -- 4.0

-- Record update syntax:
def moveRight (p : Point) (dx : Float) : Point :=
  { p with x := p.x + dx }

#eval (moveRight p1 1.0).x   -- 4.0

-- ─────────────────────────────────────────────────────────────────────────────
-- EXERCISES
-- ─────────────────────────────────────────────────────────────────────────────

-- EXERCISE 2.1: Define `Shape` as an inductive type with constructors:
--   `circle` (takes a Float radius) and `rect` (takes Float width and height).
-- EXERCISE: fill in the sorry below
inductive Shape where
  sorry

-- EXERCISE 2.2: Write `area : Shape → Float` using pattern matching.
-- EXERCISE: fill in the sorry below
def area : Shape → Float := sorry

-- EXERCISE 2.3: Define a structure `Person` with fields `name : String` and
-- `age : Nat`. Create an instance with your own name and age.
-- EXERCISE: fill in the sorry below
structure Person where
  sorry

-- Verify:
-- #eval area (Shape.circle 5.0)   -- should be ~78.54
-- #eval area (Shape.rect 3.0 4.0) -- should be 12.0
```

- [ ] **Step 2: Create `LeanLearning/Ch03_TypeClasses.lean`**

Contents:
```lean
/-
  Chapter 3: Type Classes
  =======================
  Lean4's type class system is essentially Haskell's, with some Coq-flavored
  additions (type classes as structures, instance search like Coq's typeclass
  resolution).

  If you know Haskell: almost identical syntax. `class` / `instance` / `deriving`.
  If you know Coq: type classes here are closer to Haskell's than Coq's
  (Coq uses `Class`/`Instance` but they're more like records).
-/

-- ─────────────────────────────────────────────────────────────────────────────
-- 3.1  Defining a Type Class
-- ─────────────────────────────────────────────────────────────────────────────
-- `class` defines a type class. In Haskell: `class`. In Coq: `Class`.

class Describable (α : Type) where
  describe : α → String

-- ─────────────────────────────────────────────────────────────────────────────
-- 3.2  Instances
-- ─────────────────────────────────────────────────────────────────────────────
-- `instance` provides an implementation. In Haskell: `instance`. In Coq: `Instance`.

inductive Fruit where | apple | banana | cherry deriving Repr

instance : Describable Fruit where
  describe
    | Fruit.apple  => "A crisp red apple"
    | Fruit.banana => "A yellow banana"
    | Fruit.cherry => "A small red cherry"

instance : Describable Nat where
  describe n := s!"The number {n}"

-- Usage — type class constraint with `[Describable α]`:
def printDescription [Describable α] (x : α) : IO Unit :=
  IO.println (describe x)

#eval printDescription Fruit.banana   -- "A yellow banana"
#eval printDescription (42 : Nat)     -- "The number 42"

-- ─────────────────────────────────────────────────────────────────────────────
-- 3.3  Standard Type Classes
-- ─────────────────────────────────────────────────────────────────────────────
-- Lean4's standard library has: `Repr`, `ToString`, `BEq`, `Ord`,
-- `Inhabited`, `Functor`, `Monad`, etc. — very similar to Haskell's Prelude.

-- `ToString` is like Haskell's `Show`:
instance : ToString Fruit where
  toString
    | Fruit.apple  => "apple"
    | Fruit.banana => "banana"
    | Fruit.cherry => "cherry"

#eval toString Fruit.apple   -- "apple"
#eval s!"I have a {Fruit.cherry}"   -- "I have a cherry"

-- `BEq` provides `==` (boolean equality):
instance : BEq Fruit where
  beq
    | Fruit.apple,  Fruit.apple  => true
    | Fruit.banana, Fruit.banana => true
    | Fruit.cherry, Fruit.cherry => true
    | _,            _            => false

#eval Fruit.apple == Fruit.apple    -- true
#eval Fruit.apple == Fruit.banana   -- false

-- ─────────────────────────────────────────────────────────────────────────────
-- 3.4  `deriving` — Auto-generated Instances
-- ─────────────────────────────────────────────────────────────────────────────
-- Like Haskell's `deriving`, Lean4 can auto-generate instances:

inductive Season where
  | spring | summer | autumn | winter
deriving Repr, BEq, DecidableEq

#eval Season.summer == Season.summer   -- true
#eval Season.spring == Season.winter   -- false

-- ─────────────────────────────────────────────────────────────────────────────
-- EXERCISES
-- ─────────────────────────────────────────────────────────────────────────────

-- EXERCISE 3.1: Define a type class `Area` with method `area : α → Float`.
-- EXERCISE: fill in the sorry below
class Area (α : Type) where
  sorry

-- EXERCISE 3.2: Define `inductive Geo` with constructors `circle (r : Float)`
-- and `rect (w h : Float)`, then write an `instance : Area Geo`.
-- EXERCISE: fill in the sorry below
inductive Geo where
  sorry

-- EXERCISE 3.3: Write a generic function `printArea [Area α] (x : α) : IO Unit`.
-- EXERCISE: fill in the sorry below
def printArea [Area α] (x : α) : IO Unit := sorry
```

- [ ] **Step 3: Create `LeanLearning/Ch04_Monads.lean`**

Contents:
```lean
/-
  Chapter 4: Monads and IO
  ========================
  Lean4's monad story is very Haskell-like. The `do`-notation desugars to
  `bind` (`>>=`). The `IO` monad is the main effects type.

  If you know Haskell: this is almost identical. `IO`, `Option` (≈ `Maybe`),
  `Except` (≈ `Either`), `StateM` (≈ `State`).
  If you know Coq: Coq is pure; monadic effects are encoded as data.
  Lean4's `IO` monad is a real runtime effect — not just a proof artifact.
-/

-- ─────────────────────────────────────────────────────────────────────────────
-- 4.1  The IO Monad
-- ─────────────────────────────────────────────────────────────────────────────
-- `IO α` is an IO action that produces a value of type `α`.
-- `IO Unit` ≈ Haskell's `IO ()`.

def printTwice (s : String) : IO Unit := do
  IO.println s
  IO.println s

#eval printTwice "hello"

-- `<-` extracts values from IO:
def readAndEcho : IO Unit := do
  let line ← IO.getLine
  IO.println s!"You typed: {line}"

-- ─────────────────────────────────────────────────────────────────────────────
-- 4.2  Option (Maybe)
-- ─────────────────────────────────────────────────────────────────────────────
-- `Option α` ≈ Haskell's `Maybe a`. `some x` ≈ `Just x`. `none` ≈ `Nothing`.

def safeDiv (n d : Nat) : Option Nat :=
  if d == 0 then none else some (n / d)

#eval safeDiv 10 2   -- some 5
#eval safeDiv 10 0   -- none

-- `Option` is a `Monad` — you can use `do`-notation with it:
def safeCalc (a b c : Nat) : Option Nat := do
  let x ← safeDiv a b
  let y ← safeDiv x c
  return y

#eval safeCalc 100 5 4   -- some 5
#eval safeCalc 100 0 4   -- none  (short-circuits on first failure)

-- ─────────────────────────────────────────────────────────────────────────────
-- 4.3  Except (Either)
-- ─────────────────────────────────────────────────────────────────────────────
-- `Except ε α` ≈ Haskell's `Either ε α`. `ok x` ≈ `Right x`. `error e` ≈ `Left e`.

def safeDivE (n d : Nat) : Except String Nat :=
  if d == 0
  then Except.error s!"Division by zero: {n} / {d}"
  else Except.ok (n / d)

#eval safeDivE 10 2   -- Except.ok 5
#eval safeDivE 10 0   -- Except.error "Division by zero: 10 / 0"

-- ─────────────────────────────────────────────────────────────────────────────
-- 4.4  Functor and Monad
-- ─────────────────────────────────────────────────────────────────────────────
-- `Functor` provides `map` (≈ Haskell's `fmap`):
#eval Option.map (· + 1) (some 5)   -- some 6
#eval Option.map (· + 1) none       -- none

-- `Monad` provides `bind` (≈ Haskell's `>>=`):
-- do { x <- m; f x }  ≡  m >>= fun x => f x

-- ─────────────────────────────────────────────────────────────────────────────
-- EXERCISES
-- ─────────────────────────────────────────────────────────────────────────────

-- EXERCISE 4.1: Write `safeHead : List α → Option α` returning the first
-- element of a list, or `none` if empty.
-- EXERCISE: fill in the sorry below
def safeHead (xs : List α) : Option α := sorry

-- EXERCISE 4.2: Using `do`-notation with `Option`, write `safeSecond` that
-- returns the second element of a list (or `none`).
-- Hint: use `safeHead` twice on the list and its tail.
-- EXERCISE: fill in the sorry below
def safeSecond (xs : List α) : Option α := sorry

-- EXERCISE 4.3: Write an IO action `countdown : Nat → IO Unit` that prints
-- n, n-1, ..., 1, "Go!" using recursion and `IO.println`.
-- EXERCISE: fill in the sorry below
def countdown : Nat → IO Unit := sorry

-- Verify:
#eval safeHead [1, 2, 3]    -- some 1
#eval safeHead ([] : List Nat)  -- none
#eval safeSecond [1, 2, 3]  -- some 2
#eval countdown 3
-- 3
-- 2
-- 1
-- Go!
```

- [ ] **Step 4: Create `LeanLearning/Ch05_Proofs.lean`**

Contents:
```lean
/-
  Chapter 5: First Proofs
  =======================
  Lean4's proof mode — where it starts to feel like Coq.

  If you know Coq: Lean4's tactic mode is very similar. Key differences:
    - Tactics use `by` keyword instead of a separate `Proof.`/`Qed.` block
    - `rfl` proves `a = a` (like Coq's `reflexivity`)
    - `simp` is Lean4's powerful simplifier (≈ Coq's `simp`/`ring`/`omega`)
    - `omega` solves linear arithmetic over Nat/Int (≈ Coq's `omega`/`lia`)
    - `exact h` provides a proof term directly (≈ Coq's `exact`)
    - `apply f` applies a lemma (≈ Coq's `apply`)

  If you know Haskell: Lean4 proofs are like Haskell types taken to the
  extreme — propositions ARE types, proofs ARE values (Curry-Howard).
-/

-- ─────────────────────────────────────────────────────────────────────────────
-- 5.1  Propositions and Theorems
-- ─────────────────────────────────────────────────────────────────────────────
-- `theorem` is like `def` but for propositions. The body is a proof.
-- `Prop` is the type of propositions (≈ Coq's `Prop`).

-- The simplest proof: reflexivity.
theorem one_plus_one : 1 + 1 = 2 := by rfl

-- `rfl` proves goals of the form `a = a` (after reduction).
-- In Coq: `reflexivity.` or `auto.`

-- ─────────────────────────────────────────────────────────────────────────────
-- 5.2  `by` and Tactic Mode
-- ─────────────────────────────────────────────────────────────────────────────
-- `by` enters tactic mode. What follows is a sequence of tactics.
-- In Coq: after `Proof.`, before `Qed.`

theorem add_zero (n : Nat) : n + 0 = n := by
  rfl   -- Lean4 knows n + 0 = n by definition of addition

theorem zero_add (n : Nat) : 0 + n = n := by
  simp  -- needs simplification (not definitionally equal)

-- ─────────────────────────────────────────────────────────────────────────────
-- 5.3  `simp` — The Simplifier
-- ─────────────────────────────────────────────────────────────────────────────
-- `simp` applies a set of rewrite rules automatically.
-- In Coq: `simp` / `ring` / `auto` depending on the goal.

theorem add_comm_example (a b : Nat) : a + b = b + a := by
  simp [Nat.add_comm]

-- ─────────────────────────────────────────────────────────────────────────────
-- 5.4  `omega` — Linear Arithmetic
-- ─────────────────────────────────────────────────────────────────────────────
-- `omega` decides linear arithmetic over Nat and Int automatically.
-- In Coq: `omega` or `lia`.

theorem nat_le_add (n m : Nat) : n ≤ n + m := by omega

theorem int_arith (a b : Int) : a + b = b + a := by omega

-- ─────────────────────────────────────────────────────────────────────────────
-- 5.5  `exact` and Proof Terms
-- ─────────────────────────────────────────────────────────────────────────────
-- You can provide proof terms directly without tactics:

theorem and_intro (p q : Prop) (hp : p) (hq : q) : p ∧ q :=
  And.intro hp hq

-- Or mix tactics and proof terms:
theorem and_left (p q : Prop) (h : p ∧ q) : p := by
  exact h.left

-- ─────────────────────────────────────────────────────────────────────────────
-- EXERCISES
-- ─────────────────────────────────────────────────────────────────────────────

-- EXERCISE 5.1: Prove that `2 + 2 = 4`.
-- EXERCISE: fill in the sorry below
theorem two_plus_two : 2 + 2 = 4 := by sorry

-- EXERCISE 5.2: Prove that for any Nat n, `n ≤ n + 1`.
-- Hint: try `omega`.
-- EXERCISE: fill in the sorry below
theorem le_succ (n : Nat) : n ≤ n + 1 := by sorry

-- EXERCISE 5.3: Prove `(p ∧ q) → p` (conjunction elimination).
-- Hint: `intro h` introduces the hypothesis, `exact h.left` uses its left field.
-- EXERCISE: fill in the sorry below
theorem and_elim_left (p q : Prop) : p ∧ q → p := by sorry

-- EXERCISE 5.4: Prove `p ∨ q → q ∨ p` (disjunction commutativity).
-- Hint: `intro h`, then `cases h with | inl hp => ... | inr hq => ...`
-- EXERCISE: fill in the sorry below
theorem or_comm' (p q : Prop) : p ∨ q → q ∨ p := by sorry
```

- [ ] **Step 5: Create `LeanLearning/Ch06_DependentTypes.lean`**

Contents:
```lean
/-
  Chapter 6: Dependent Types — Where PL Meets Proofs
  ===================================================
  This is where Lean4 truly unifies programming and theorem proving.
  Dependent types let types depend on *values* — enabling type-safe
  programming with compile-time guarantees.

  If you know Coq: you're home. `Fin n` ≈ Coq's `Fin n`. Dependent
  functions `(x : α) → β x` ≈ Coq's `forall (x : α), β x`.
  If you know Haskell: this goes beyond GHC's type system. The closest
  analogs are GADTs and DataKinds, but Lean4's are far more expressive.
-/

-- ─────────────────────────────────────────────────────────────────────────────
-- 6.1  Dependent Function Types (Π-types)
-- ─────────────────────────────────────────────────────────────────────────────
-- A dependent function's return type can mention the argument's *value*.
-- In Coq: `forall (n : Nat), Vec α n`. In Haskell: no direct equivalent.

-- The type `(n : Nat) → Vector α n` means: given a Nat n, produce a
-- Vector whose *length is n*. The type depends on the value.

-- ─────────────────────────────────────────────────────────────────────────────
-- 6.2  `Fin n` — Bounded Naturals
-- ─────────────────────────────────────────────────────────────────────────────
-- `Fin n` is the type of natural numbers less than n.
-- Values: 0, 1, ..., n-1. Out-of-bounds is a *type error*, not a runtime error.
-- In Coq: `Fin n`. In Haskell: approximated with `Data.Fin` (non-standard).

#check (⟨2, by omega⟩ : Fin 5)   -- element 2 of {0,1,2,3,4}

-- Safe array indexing using `Fin`:
def safeGet (xs : Array α) (i : Fin xs.size) : α :=
  xs[i]   -- no bounds check needed — i's type guarantees it's valid!

-- ─────────────────────────────────────────────────────────────────────────────
-- 6.3  `Prop` vs `Type`
-- ─────────────────────────────────────────────────────────────────────────────
-- `Prop` is the universe of propositions (proof-irrelevant).
-- `Type` is the universe of data types (proof-relevant).
-- In Coq: `Prop` and `Type` — identical distinction.
-- In Haskell: no `Prop` — all types are `Type` (data).

-- A value in `Prop` is a proof — you only care that it exists, not which one.
-- A value in `Type` is data — the specific value matters.

theorem prop_example : 1 + 1 = 2 := rfl   -- lives in `Prop`
def type_example : Nat := 1 + 1            -- lives in `Type`

-- ─────────────────────────────────────────────────────────────────────────────
-- 6.4  Proof-Carrying Data
-- ─────────────────────────────────────────────────────────────────────────────
-- You can embed proofs in data structures to enforce invariants at the type level.

-- A non-empty list: a list paired with a proof that it's non-empty.
structure NonEmptyList (α : Type) where
  val  : List α
  prop : val ≠ []   -- proof that the list is non-empty

def neHead (nel : NonEmptyList α) : α :=
  match nel.val, nel.prop with
  | [],     h => absurd rfl h   -- impossible — `h` says it's non-empty
  | x :: _, _ => x

-- ─────────────────────────────────────────────────────────────────────────────
-- EXERCISES
-- ─────────────────────────────────────────────────────────────────────────────

-- EXERCISE 6.1: Create a `Fin 10` value representing the number 7.
-- Hint: `⟨7, by omega⟩`
-- EXERCISE: fill in the sorry below
def seven : Fin 10 := sorry

-- EXERCISE 6.2: Write a function `allFin (n : Nat) : List (Fin n)` that
-- returns a list of all values in `Fin n`.
-- Hint: use `List.finRange`.
-- EXERCISE: fill in the sorry below
def allFin (n : Nat) : List (Fin n) := sorry

-- EXERCISE 6.3: Define a structure `Positive` containing a Nat and a proof
-- that it's greater than 0. Then define `positiveDiv` that divides two
-- Positive values (safe — denominator is provably nonzero).
-- EXERCISE: fill in the sorry below
structure Positive where
  sorry
```

- [ ] **Step 6: Create notes stubs for chapters 2–6**

Create `/home/traian/lean4/notes/Ch02_Types.md`:
```markdown
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
| `{ s with f := v }` | `s { f = v }` | `{| f := v |}` |

## Gotchas
- Constructors are namespaced: `Color.red`, not just `red` (unless opened).
- `deriving Repr` is needed for `#eval` to display custom types.
- Structures have exactly one constructor (the record itself).

## Next
→ [Chapter 3: Type Classes](Ch03_TypeClasses.md)
```

Create `/home/traian/lean4/notes/Ch03_TypeClasses.md`:
```markdown
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
```

Create `/home/traian/lean4/notes/Ch04_Monads.md`:
```markdown
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
```

Create `/home/traian/lean4/notes/Ch05_Proofs.md`:
```markdown
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
```

Create `/home/traian/lean4/notes/Ch06_DependentTypes.md`:
```markdown
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
```

---

### Task 7: Verify `lake build` passes and make initial commit

**Files:** No new files — verification and commit only.

- [ ] **Step 1: Ensure elan is in PATH**

```bash
export PATH="$HOME/.elan/bin:$PATH"
```

- [ ] **Step 2: Run `lake build` from the repo root**

```bash
cd /home/traian/lean4
lake build
```

Expected: build succeeds with warnings for `sorry` usages but **zero errors**.
First run downloads the Lean toolchain (~500 MB) — may take several minutes.

If you see errors (not warnings), the most common causes:
- Missing `LeanLearning.lean` root file
- Wrong `lean-toolchain` contents (must be `leanprover/lean4:stable`)
- Syntax error in a chapter file — check the error message for the file and line

- [ ] **Step 3: Stage all files**

```bash
cd /home/traian/lean4
git add README.md CLAUDE.md lean-toolchain .gitignore lakefile.toml \
        LeanLearning.lean LeanLearning/ notes/ docs/
```

- [ ] **Step 4: Make the initial commit**

```bash
git commit -m "feat: initial Lean4 learning log scaffold

- elan/Lake project with LeanLearning package
- Chapter 1 (Basics) fully written with exercises
- Skeleton chapters 2-6 with sorry-gap exercises
- Parallel notes/ markdown files for each chapter
- README with setup instructions
- CLAUDE.md with AI assistant guidelines"
```

- [ ] **Step 5: Confirm the build and verify sorry warnings appear**

```bash
lake build 2>&1 | grep -E "(warning|error|Build)"
```

Expected: lines like `warning: declaration uses 'sorry'` for each exercise, and `Build completed successfully.` at the end. Zero lines containing `error:` (other than in sorry warnings).

---

## Self-Review

**Spec coverage check:**
- ✅ elan installation (Task 1)
- ✅ git init (Task 2)
- ✅ lean-toolchain, .gitignore, lakefile.toml, README.md, CLAUDE.md (Tasks 2–3)
- ✅ VSCode extension leanprover.lean4 (Task 4)
- ✅ Ch01 fully written with Coq/Haskell bridging (Task 5)
- ✅ Ch02-Ch06 skeletons with sorry-gaps (Task 6)
- ✅ notes/ .md files for all chapters (Task 6)
- ✅ `lake build` verification (Task 7)
- ✅ Initial commit (Task 7)

**Placeholder scan:** No TBD/TODO in plan steps — all code is complete. ✅

**Type consistency:** No cross-task type dependencies (each task is independent). ✅
