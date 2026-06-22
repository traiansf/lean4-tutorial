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
