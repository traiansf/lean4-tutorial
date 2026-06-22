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
  let stdin ← IO.getStdin
  let line ← stdin.getLine
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
-- Uncomment after filling in the exercises above
-- #eval safeHead [1, 2, 3]    -- some 1
-- #eval safeHead ([] : List Nat)  -- none
-- #eval safeSecond [1, 2, 3]  -- some 2
-- #eval countdown 3
-- -- 3
-- -- 2
-- -- 1
-- -- Go!
