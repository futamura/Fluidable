# MEMORY.md

本ファイルは `Fluidable` の project memory index。Codex / Claude Code は新規タスク開始時に必ず読む。

canonical store は repo 内 `docs/memory/`。Claude Code 側の project auto memory path は、この directory への symlink として扱う。Codex は Claude Code の自動 memory 読み込みを前提にせず、本ファイルと関連 memory を明示的に読む。

## Feedback

現時点で project-local feedback は未登録。

## Gotchas

- [gotcha_docs_case.md](gotcha_docs_case.md) — 既存 `docs/` があるため、`Docs/` を新設・混在させない。

## Projects

現時点で進行中 project memory は未登録。

## Tasks

### In Progress

なし。

### Backlog

なし。

### Icebox

なし。

### Frozen

なし。

### Done

- [x] **#1 Repository guidelines 初期作成** — 2026-05-19 / `AGENTS.md`, `CLAUDE.md`, `CODING-GUIDE.md`, `docs/memory/` を作成。

## Memory 運用メモ

- 新規 task は `#NN` ID を採番し、`Tasks` の適切な section に追加する。
- ユーザー規律や好みは `feedback_*`、技術的 gotcha は `gotcha_*`、特定 task の詳細は `project_*` に分離する。
- 完了済みの長い記録は `docs/memory/archive/` に移し、ここには link と短い要約だけ残す。
