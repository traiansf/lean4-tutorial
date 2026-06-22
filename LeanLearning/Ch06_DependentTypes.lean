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
