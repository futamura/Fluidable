# AGENTS.md

本ファイルは Codex 用 entrypoint。

## Session bootstrap

新規タスクで実装・ファイル編集・本格的な調査コマンドに入る前に、必ず以下を行う。

1. `pwd` で CWD が repo-root (`Fluidable/`) であることを確認する。
2. `CODING-GUIDE.md` を読む。
3. `.agents/memory/MEMORY.md` を読む。
4. `MEMORY.md` の `Feedback` / `Gotchas` / `Projects` / `Tasks` を確認し、当該タスクに関連する `feedback_*`, `gotcha_*`, `project_*` を読む。
5. `CODING-GUIDE.md` の Verification Gate / Commit Gate を参照し、当該タスクの必須 verification を抽出する。
6. 読んだ前提と必須 verification gate を反映してから、作業方針を提示する。

`@CODING-GUIDE.md` は補助参照であり、この bootstrap を省略する理由にはならない。

本リポジトリの共通作業指針は `CODING-GUIDE.md` に置く。Codex は作業開始前に同ファイルを読み、その内容に従う。

@CODING-GUIDE.md
