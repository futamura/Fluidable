# feedback_branch_flow

## 概要

本 repo は `develop` 中心の branch flow で運用する。

## ルール

- 通常作業は `develop` から作業ブランチを切る。
- 作業完了後の merge target は原則 `develop`。
- `master` は version up / release 公開時のみ merge する。
- `master` を通常作業ブランチの base として案内しない。
