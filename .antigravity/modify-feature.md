# ✏️ Modify Feature Workflow (Safe Refactor + Impact Analysis)

---

## 🎯 Trigger

Use this workflow when:

* Modifying existing feature
* Refactoring code
* Adding logic to existing flow
* Fixing bugs in feature

---

## 🚨 Golden Rule

**NEVER modify code before understanding full impact.**

---

## 🧠 Phase 1 — Impact Analysis (MANDATORY)

### 🔍 Step 1 — Locate Entry Point

* [ ] Identify where the change starts:

  * UI (View / Widget)
  * Cubit method
  * Repository method
  * DataSource method

---

### 🔍 Step 2 — Trace Full Flow

Trace both directions:

#### 📥 Upstream (Who calls this?)

* [ ] Search for all usages (Find References)
* [ ] Identify all screens / cubits using it

#### 📤 Downstream (What does it affect?)

* [ ] What methods are called inside?
* [ ] What models are used?
* [ ] What APIs are hit?

---

### 🔍 Step 3 — Dependency Check

* [ ] Check DI (GetIt registrations)
* [ ] Check Router (navigation impact)
* [ ] Check shared widgets usage
* [ ] Check global states / shared cubits

---

### 🔍 Step 4 — Data Impact

* [ ] Will Model change?
* [ ] Will API response shape change?
* [ ] Will existing data break?

---

### 🔍 Step 5 — Risk Classification

Classify change:

* 🟢 Low Risk:

  * UI only
  * Styling
  * Local widget changes

* 🟡 Medium Risk:

  * Cubit logic
  * New state
  * Small repo change

* 🔴 High Risk:

  * Model change
  * API contract change
  * Shared dependency change

---

## 🧱 Phase 2 — Plan Before Code

* [ ] Define exact change
* [ ] List affected files
* [ ] Decide minimal modification strategy
* [ ] Avoid breaking existing behavior
* [ ] Prefer extension over modification

---

## ✍️ Phase 3 — Implementation Rules

---

### 🔹 Rule 1 — Minimal Changes

* Only modify what is necessary
* Do NOT rewrite entire files

---

### 🔹 Rule 2 — Backward Compatibility

* Do not break existing usage
* If needed:

  * Add optional params
  * Add new methods instead of editing old

---

### 🔹 Rule 3 — Layer Safety

* UI:

  * No business logic
* Cubit:

  * No API calls
  * Use fold pattern only
* Repo:

  * Return ApiResult only
* DataSource:

  * No logic

---

### 🔹 Rule 4 — State Safety

* Do not remove existing states unless unused
* Add new states if needed (don’t overload old ones)

---

### 🔹 Rule 5 — Model Safety

* Prefer:

  * Add fields (nullable)
* Avoid:

  * Renaming/removing fields unless required

---

## 🧪 Phase 4 — Verification

* [ ] All previous flows still work
* [ ] No broken navigation
* [ ] No runtime crashes
* [ ] No state inconsistencies
* [ ] `dart analyze` → 0 issues

---

## 🔍 Phase 5 — Regression Check (IMPORTANT)

* [ ] Test old use cases
* [ ] Test new change
* [ ] Check edge cases
* [ ] Verify error handling still works

---

## 🚫 Strict Rules (DO NOT BREAK)

* ❌ No blind edits
* ❌ No breaking API contracts
* ❌ No removing used methods
* ❌ No skipping impact analysis
* ❌ No rewriting working code without reason

---

## 🧠 Architecture Flow Reminder

UI → Cubit → Repo → DataSource → API

---

## 💡 Pro Tips

* Use "Find All References" heavily
* Read code twice before editing
* Think in side-effects, not just direct change
* If unsure → add new method instead of editing old

---

## 🔥 Golden Mindset

**"Every change has a ripple effect — your job is to see the ripple before it happens."**
