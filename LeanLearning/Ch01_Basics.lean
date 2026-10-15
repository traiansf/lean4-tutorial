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

-- Partial application works (like Haskell), but #eval can't display functions:
--   (add 3) : Nat → Nat   -- a partially-applied function waiting for its second arg

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
  let stdin ← IO.getStdin
  let name ← stdin.getLine
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
-- EXERCISE: fill in the sorry below
def square (n : Nat) : Nat := n * n

-- EXERCISE 1.2: Define `max'` returning the larger of two Nat values.
-- Hint: use `if ... then ... else ...`
-- EXERCISE: fill in the sorry below
def max' (a b : Nat) : Nat :=
  if a > b then a else b

-- EXERCISE 1.3: Define `greet` that performs IO, printing "Hello, <name>!"
-- EXERCISE: fill in the sorry below
def greet (name : String) : IO Unit :=
  IO.println s!"Hello, {name}!"

-- EXERCISE 1.4: What does `(5 : Nat) - 8` evaluate to? Why?
-- Write your answer as a comment, then verify with #eval.
-- ANSWER: 0

-- Verify your answers (uncomment after filling in the exercises above):
#eval square 6       -- should be 36
#eval max' 3 7       -- should be 7
#eval max' 9 2       -- should be 9
#eval greet "Lean4"  -- should print: Hello, Lean4!

def fact (n : Nat) : Nat := if n = 0 then 1 else n * fact (n - 1)

#eval fact 4
