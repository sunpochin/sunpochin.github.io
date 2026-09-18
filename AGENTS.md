# Project Rules & Constitution (核心憲法)

All AI agents must strictly follow this canonical source of truth. Do not invent or follow conflicting rules.
所有 AI Agent 必須嚴格遵守此規則。請勿自行發明或遵循相衝突之規則。

---

## 1. Tool Hierarchy (工具定位)

* **Primary Engineer (Claude Code)**: 
  - Main Surgeon (主刀醫師). Handles architecture decisions, production code changes, database migrations, security policies, and final reviews of other agents' work.
* **Secondary Assistant (Antigravity)**: 
  - Intern/Scout (實習生/探路員). Handles implementation planning, UI prototyping, browser verification, low-risk patches, and task screenshots. Important changes must be reviewed by Claude Code or the User.

---

## 2. Prime Directive (最高原則)

Every code modification, regardless of size, must execute these 4 steps:
每次修改，不論大小，都必須執行以下四個步驟：

1. **ELI5 Explanation (小朋友解說)**: 
   - Provide a extremely simple, non-technical explanation of the changes in the final chat response.
   - 在回應裡用最簡單的語言說明這個改動做了什麼，讓完全不懂技術的人也看得懂。
2. **Why-Not-What Comments (程式碼註解)**: 
   - Add concise Traditional Chinese comments in the modified code explaining "why" a change was made (not just "what" the code does). Highlight traps, non-obvious decisions, or execution orders.
   - 在修改的程式碼裡加上繁體中文註解，說明「為什麼這樣做」。特別標明有坑、非直覺決策與重要執行順序。
3. **Technical Docs (技術文件)**: 
   - Update `TECHNICAL.md` for feature or architectural changes, detailing design decisions and rejected alternatives.
   - 涉及架構或新功能時更新 `TECHNICAL.md`，說明設計決策與排除的替代方案。
4. **Commit, Push & PR (自動推送與開立 PR)**: 
   - Work on a new branch. Commit and push immediately after completing a single task. Do not accumulate commits.
   - 所有修正都必須開新分支。每做好一件事立刻 commit 且 push，不累積。
   - Commit Message Format: `type: Title\n\nDetailed why-explanation`
   - **Git Workflow Strict Rule**: If committing on a branch other than `main`, automatically and directly push the changes to the remote Git repository without waiting for user instructions. Do not push directly to the `main` branch.
   - **Auto PR Creation (自動開立 PR 省使用者時間，參考 Jia-Jian Log 憲法規範)**:
     - 功能或修正完成、驗證、提交並推送到遠端分支後，必須**立即**使用 `gh pr create` 自動開立**非 Draft** 的 Pull Request（目標分支通常為 `main` 或專案之預設基線分支，如 `staging`）。不得等待使用者額外提醒，也不得讓遠端分支推上去卻沒有 PR。
     - PR 內容須包含：變更摘要、動機原因、受影響範圍與驗證結果。

---

## 3. Safety Boundaries & Destructive Commands (安全政策)

Never run destructive commands without explicit user approval.
未經使用者明確同意，絕對不可執行破壞性指令。

* **Forbidden Commands**: `rm -rf` (mass deletion), `git reset --hard`, `git clean -fd`, `drop table`, `truncate table`, `supabase db reset`, `supabase db push`, `vercel deploy --prod`, overwriting `.env` files.
* **Protected Resources**: `.env*` files, OAuth credentials, Supabase service role keys, private certificates, production databases.

---

## 4. Coding & Testing Workflow (開發與測試流程)

1. Claude Code reads `AGENTS.md` and implements the primary feature/fix.
2. Antigravity can be called to draft plans, prototype UI, and perform browser-based verification.
3. Verify changes by running existing unit tests and linters.
4. Inspect `git diff` carefully before preparing the commit.
5. Create a clean commit on a feature branch, and push immediately.
6. Automatically create a non-draft Pull Request using `gh pr create`.

---

## 5. Task Completion Report (任務完成回報規範)

When finishing implementation or git-related work, the final response must end with a structured summary:

### Done
- Bulleted list of key changes made.

### Validation
- Tests/linters/typechecks executed and their pass/fail results (e.g. `bun test tests/unit/... ✅`).

### Git
- **Branch**: `<branch-name>`
- **Commit**: `<short-sha>` (if a commit was created)
- **PR**: Query via `gh pr view --json url --jq '.url'`
  - Pull Request URL: `https://github.com/<owner>/<repo>/pull/<number>`

