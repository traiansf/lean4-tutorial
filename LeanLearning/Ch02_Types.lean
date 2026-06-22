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

-- Shape is defined for you — study how inductive types with constructor
-- arguments work (compare to Haskell's `data` or Coq's `Inductive`).
inductive Shape where
  | circle : Float → Shape
  | rect   : Float → Float → Shape
deriving Repr

-- EXERCISE 2.1: Write `area : Shape → Float` using pattern matching.
--   circle: π × r²   (use Float.pi or 3.14159265)
--   rect:   w × h
-- EXERCISE: fill in the sorry below
def area : Shape → Float := sorry

-- Person is defined for you — note how `structure` is like Haskell record syntax
-- or Coq's `Record`.
structure Person where
  name : String
  age  : Nat
deriving Repr

-- EXERCISE 2.3: Create a `Person` instance with your own name and age.
-- EXERCISE: fill in the sorry below
def me : Person := sorry

-- Verify:
-- #eval area (Shape.circle 5.0)   -- should be ~78.54
-- #eval area (Shape.rect 3.0 4.0) -- should be 12.0
