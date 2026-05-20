# MEMORY.md

本ファイルは `Fluidable` の project memory index。coding agent は新規タスク開始時に必ず読む。

canonical store は repo 内 `.agents/memory/`。agent 固有の自動 memory 読み込みは前提にせず、本ファイルと関連 memory を明示的に読む。

## Feedback

現時点で project-local feedback は未登録。

## Gotchas

- [gotcha_docs_case.md](gotcha_docs_case.md) — 既存 `docs/` があるため、`Docs/` を新設・混在させない。

## Projects

- [project_xcode26_spm_migration.md](project_xcode26_spm_migration.md) — Xcode 26 / iOS 15-26 / SPM 完全移行。
- [project_docc_output_policy.md](project_docc_output_policy.md) — DocC 生成 docs の再現性・local preview・公開方針調査。

## Tasks

### In Progress

- [ ] **#10 DocC generated docs reproducibility / output policy 整理** — 2026-05-20 更新 / 調査結果は [project_docc_output_policy.md](project_docc_output_policy.md) に記録。`file://.../docs/index.html` 直開き失敗は生成欠損ではなく、`/Fluidable/` base path の HTTP static hosting 前提が主因。`fastlane ios create_doc` の連続実行で JSON key order、`docs/index/*.index` binary、生成 JS trailing whitespace の差分を確認済み。実装・設定変更・生成物 commit は未承認。

### Backlog

- [ ] **#7 Example 挙動不具合修正** — 2026-05-20 更新 / 新規セッションで対応。Simulator / 実機確認を必須 gate にする。

### Icebox

なし。

### Frozen

なし。

### Done

- [x] **#9 SwiftLint / DocC warning debt 整理** — 2026-05-20 / PR #8 を `develop` へ squash merge。merge commit `91b1822`。Phase 1 で DocC source comment warnings を解消。Phase 2 で comment spacing / unused closure parameter / unused setter value / orphaned doc comment / prefer type checking / shorthand operator / trailing newline / vertical whitespace と PR 差分上の Hound line_length 指摘を整理し、SwiftLint は 152 warnings から 116 warnings へ減少。残りは accessor order / complexity / force cast / implicit optional / line length / type name / vertical parameter alignment / file length / function body length / for_where。Nimble deprecation warning は外部ライブラリ由来のため現時点では放置。
- [x] **#8 `master` -> `main` rename** — 2026-05-20 / repo 内表記を `develop` 向けに更新し、PR #5 を `develop` へ squash merge。merge commit `8a30ed5`。GitHub default branch は `main` に変更済み。local / remote `master` は削除済み。`main` への PR・merge は未実行。
- [x] **#6 PR #4 merge** — 2026-05-20 / PR #4 を `develop` へ squash merge。merge commit `7ebb9e3`。`build/xcode26-spm-migration` は local / remote とも削除済み。
- [x] **#5 PR #4 CI simulator destination 修正** — 2026-05-20 / `fastlane/ios_simulator_destination.rb` で available simulator を動的選択し、CI は runner に installed simulator がある Xcode 26.4.1 を使用。PR #4 の CI `test` と Hound は pass。
- [x] **#1 Repository guidelines 初期作成** — 2026-05-19 / agent entrypoint、`CODING-GUIDE.md`、project memory を作成。
- [x] **#2 Xcode 26 SPM migration** — 2026-05-19 / Xcode 26.5, iOS 15 minimum, SPM, mise, fastlane 整理。
- [x] **#3 Tooling DocC coverage migration** — 2026-05-19 / SwiftLint mise 管理、Jazzy から DocC、Slather から xccov/Codecov へ移行。
- [x] **#4 Agent docs relocation** — 2026-05-19 / `docs/` を DocC 専用化し、memory / superpowers を `.agents/` 配下へ移動。

## Memory 運用メモ

- 新規 task は `#NN` ID を採番し、`Tasks` の適切な section に追加する。Backlog / Icebox / Frozen に無番号 task を追加しない。
- 未完 task entry は `- [ ] **#NN タスク名** — YYYY-MM-DD 更新 / 内容...` 形式にする。日付はその entry を最後に実質更新した日を指す。
- ユーザー規律や好みは `feedback_*`、技術的 gotcha は `gotcha_*`、特定 task の詳細は `project_*` に分離する。
- branch / PR / commit などの project 運用ルール本文は `CODING-GUIDE.md` に置き、memory には task 状態と短い参照だけを置く。
- 完了済みの長い記録は `.agents/memory/archive/` に移し、ここには link と短い要約だけ残す。
