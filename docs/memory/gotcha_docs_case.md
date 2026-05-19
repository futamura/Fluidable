# gotcha_docs_case.md

## 概要

本 repo には既存の `docs/` directory があり、Jazzy 生成 documentation が入っている。

macOS の case-insensitive filesystem では `docs/` と `Docs/` が衝突しやすい。project-local docs / memory / specs / plans は `docs/` に統一し、`Docs/` を新設しない。

## 判断

- memory canonical store: `docs/memory/`
- Claude Code auto memory symlink target: `docs/memory/`
- Codex / Claude Code entrypoint から読む memory path: `docs/memory/MEMORY.md`
