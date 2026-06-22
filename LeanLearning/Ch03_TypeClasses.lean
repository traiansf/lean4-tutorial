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
  IO.println (Describable.describe x)

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
-- EXERCISE: replace the placeholder method below
class Area (α : Type) where
  area : α → Float   -- replace with your implementation

-- EXERCISE 3.2: Define `inductive Geo` with constructors `circle (r : Float)`
-- and `rect (w h : Float)`, then write an `instance : Area Geo`.
-- EXERCISE: replace the placeholder constructors below
inductive Geo where
  | circle : Float → Geo           -- replace with your implementation
  | rect   : Float → Float → Geo   -- replace with your implementation

-- EXERCISE 3.3: Write a generic function `printArea [Area α] (x : α) : IO Unit`.
-- EXERCISE: fill in the sorry below
def printArea [Area α] (x : α) : IO Unit := sorry
