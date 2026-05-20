# gotcha_docs_case.md

## 概要

本 repo では `docs/` directory を Swift-DocC local generated artifact として使う。`docs/` は Git 管理しない。

macOS の case-insensitive filesystem では `docs/` と `Docs/` が衝突しやすい。Swift-DocC の local 生成物は `docs/` に統一し、project-local memory / specs / plans は `.agents/` 配下に置く。`Docs/` を新設しない。

## 判断

- memory canonical store: `.agents/memory/`
- Claude Code auto memory symlink target: `.agents/memory/`
- Codex / Claude Code entrypoint から読む memory path: `.agents/memory/MEMORY.md`
