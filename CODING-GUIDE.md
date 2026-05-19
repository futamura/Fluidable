# CODING-GUIDE.md

本ファイルは本リポジトリ (`Fluidable`) を扱う際の共通作業指針。Codex / Claude Code などの coding agent は、各 entrypoint (`AGENTS.md` / `CLAUDE.md`) から本ファイルを参照する。

Codex の全プロジェクト横断グローバルルールは `~/.codex/AGENTS.md` を参照。

## プロジェクト概要

UIKit ベースの Swift 5.0 library。`UIViewControllerTransitioningDelegate` / `UINavigationControllerDelegate` による custom transition、interactive / interruptible transition、drawer / slide / fluid presentation、resizable drawer を扱う。配布形態は Swift Package Manager。Xcode project は `Fluidable.xcodeproj`、主 scheme は `Fluidable` と `FluidableExample`。

## コマンド

repo-root から実行する。

```bash
bundle install
bundle exec fastlane ios test
bundle exec fastlane ios lint
bundle exec fastlane ios create_doc
bundle exec fastlane ios coverage
xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=<Simulator Name>'
```

- `bundle install`: Fastlane など Ruby 依存を入れる。
- `bundle exec fastlane ios test`: 共有 lane 経由で SwiftPM build / coverage 付き unit test / SwiftLint を実行する。
- `bundle exec fastlane ios lint`: `Sources/` に mise 管理の SwiftLint を実行する。
- `bundle exec fastlane ios create_doc`: Swift-DocC documentation を `docs/` に生成する。
- `bundle exec fastlane ios coverage`: Xcode coverage を `.xcresult` に出力し、Codecov upload 用 `xccov.txt` を生成する。
- `xcodebuild test ...`: Fastlane を介さず XCTest を実行する。

複数コマンドを `&&` / `||` / `;` で連結しない。連続実行は個別 tool call に分ける。

## アーキテクチャ

主要コードは `Sources/` 配下。

- `Sources/Core`: transition delegate、proxy、enum、core protocol
- `Sources/Layout`: frame / presentation layout 計算
- `Sources/View`: interactive view、shadow / background / progress view、corner mask layer
- `Sources/Helper`: extension、runtime helper、animator helper
- `Sources/Shared`: debug / test support
- `Sources/Error`: library error
- `Example/`: demo application source、storyboard、resources
- `Tests/`: Quick / Nimble ベースの unit tests
- `UITests/`: example app を対象にした UI tests
- `fastlane/`: test、lint、coverage、DocC、cleanup task
- `docs/`: Swift-DocC 生成 documentation
- `.agents/`: project-local memory、spec、plan

## セッション初期プロトコル

新規タスク着手前に以下を 1 メッセージで提示し、ユーザー承諾を得てから実装・ブランチ作成・ファイル編集に入る。

1. タスク分類: 調査 / ドキュメント / バグ修正 / 機能追加 / リファクタ
2. 適用 skill: 必要なもののみ列挙
3. effort level: 現在 level と推奨 level。不明なら `unknown`
4. ブランチ運用: 新規ブランチ要否と候補
5. 作業フェーズ: 調査 -> 設計 -> 計画 -> 実装 -> verification -> commit / PR
6. 確認 checkpoint: 方針変更、scope 変更、破壊的操作、認証情報、署名、課金 API、権限変更、commit / PR / merge
7. 完了後フロー: commit -> push -> PR -> merge まで一括実行するか

ユーザーの発言が質問形式の場合、作業前にまず回答する。短い返答 (`OK`, `了解`, `進めて`) は直前 checkpoint の承認に限る。

## Superpowers Workflow

実装・修正・挙動変更・重要な docs policy 変更では、superpowers workflow を必須とする。

通常 sequence:

1. session bootstrap を行う。
2. 必要な skill を読む。
3. 初期プロトコルを提示し、承認を待つ。
4. 必要なら `develop` から作業ブランチを作る。
5. `superpowers:brainstorming` で要件と代替案を整理する。
6. `superpowers:writing-plans` で implementation plan を作る。
7. implementation start の明示承認後に作業する。
8. plan と本 guide の上位 gate に従って verification を行う。
9. memory へ影響する task では `.agents/memory/MEMORY.md` を更新する。
10. Commit Gate を通過した場合のみ commit する。

phase boundary をまたぐ場合は別途承認を得る。

## Verification Gate

変更種別ごとに必須 gate を抽出し、作業方針・plan・commit 前報告に明記する。

- docs のみ: `git diff --check` と対象 markdown の目視確認。
- Swift pure logic: 関連 XCTest、または `bundle exec fastlane ios test` / `xcodebuild test`。
- transition / layout / gesture / animation: unit test に加え、Example app で該当 presentation style と interaction を Simulator または実機確認する。
- Storyboard / Auto Layout / asset / font: Simulator または実機で画面確認。変更画面、主要端末サイズ、回転有無を記録する。
- Swift Package / documentation / release: `swift package describe`、`bundle exec fastlane ios create_doc`、必要に応じて Xcode build。配布操作は dry-run と承認を優先する。
- signing / provisioning / Fastlane release: `.envrc`、証明書、keychain、token を表示・commit しない。dry-run や lane 結果を報告する。

必須 gate を `任意` / `可能なら` に弱めない。実施できない場合は理由と残リスクを明記する。

## Commit Gate

`git commit` 前に必ずユーザー承認を得る。一括承認がない限り、編集・検証の承認を commit 承認と解釈しない。

commit 承認前に提示する内容:

1. commit 対象 file list
2. staged / unstaged / untracked 状態
3. verification 結果
4. UI / 実機確認が必要な場合は checklist 結果
5. commit message 案

commit message は Conventional Commits 寄りにする。例: `docs: add agent guide`, `fix(ios): correct transition state`。`Co-Authored-By` や AI 生成署名は入れない。

## ブランチと PR

通常 task は `develop` から作業ブランチを切る。`develop` で直接作業しない。小さな docs 修正でも、ユーザーが直接 commit を明示しない限りブランチを提案する。

作業完了後の PR / merge target は原則 `develop`。まとまった更新が完了し、version up / release 公開を行う段階でのみ `master` に merge する。`master` は公開済みまたは公開準備済みの状態を保つ。

branch prefix は `docs/`, `feature/`, `fix/`, `refactor/`, `build/`, `chore/` を優先する。PR には目的、主要変更点、verification、UI 変更時のスクリーンショットまたは実機確認メモ、関連 issue を記載する。

## コーディング規約

- Swift 5.0 前提。
- indentation は 4 spaces。
- 型名は `UpperCamelCase`、method / property は `lowerCamelCase`。
- public API と delegate method は source compatibility を意識し、変更前に影響範囲を確認する。
- `Sources/` の library 実装と `Example/` の demo 実装を混同しない。
- 画像は既存の `@2x` / `@3x` と asset 配置を崩さない。
- 承認なしに Swift / Xcode / Ruby gem / Fastlane plugin / SPM dependency の version を変更しない。
- UI 色、font、spacing、既存 visual behavior は明示承認なしに変更しない。

## ドキュメント構成

Swift-DocC の公開生成物は `docs/` に集約する。macOS の case-insensitive filesystem で `docs/` と `Docs/` を混在させない。

- `docs/`: Swift-DocC 生成 documentation。agent memory / specs / plans を置かない。
- `.agents/memory/`: project memory の canonical store
- `.agents/memory/archive/`: 常時参照しない完了済み memory
- `.agents/superpowers/specs/`: 必要時の仕様書
- `.agents/superpowers/plans/`: 必要時の実行計画

## Documentation Style

repo 内に作成・更新する project docs / memory / spec / plan は、簡潔な日本語ベースで書く。

- 文体は原則「である調」または体言止め。冗長な敬体・説明口調を避ける。
- 英語テンプレートをそのまま流用しない。見出し・本文とも日本語ベースへ直す。
- `spec` / `plan` / `checkpoint` / `Visual QA` / `commit` / `PR` / `checks` / `merge` / `Figma` などの技術語は英語のままでよい。
- file path、command、API 名、code symbol、Figma node name、外部固有名詞、引用は原文のまま正確に書く。
- 1 paragraph 1 topic。長い説明より bullet と concrete condition を優先する。
- `適宜` / `必要なら` / `可能なら` などで必須 gate を弱めない。
- docs 完了前に、日本語ベースになっているか、英語テンプレート由来の section が残っていないか self-review する。

## Memory 運用

project memory の canonical store は `.agents/memory/`。Claude Code 側の project-local auto memory path は、この directory への symlink として扱う。Codex は Claude Code の自動 memory 読み込みを前提にせず、session bootstrap で明示的に読む。

`.agents/memory/MEMORY.md` は常時参照 index。全履歴ログではない。

`MEMORY.md` に置く情報:

- `Feedback` / `Gotchas` / `Projects` index
- 進行中 / pending task の短い summary
- `Tasks` section (`In Progress` / `Backlog` / `Icebox` / `Frozen` / `Done`)
- 今後も必要な invariant / decision

`MEMORY.md` に置かない情報:

- 長い session transcript
- merge 済み PR の詳細履歴
- git history / PR / spec / plan で追える重複情報

memory file の分類:

| prefix | 用途 |
| --- | --- |
| `feedback_*` | ユーザー規律 / 好み |
| `gotcha_*` | 技術的 gotcha / 非自明挙動 |
| `project_*` | 特定 task / feature の作業記録 |
| `user_*` | ユーザー背景 |

`Tasks` に新規 task を追加する場合は `#NN` ID を使う。既存最大番号を `MEMORY.md` と `.agents/memory/archive/*.md` から確認し、次の未使用番号を採番する。

## セキュリティと設定

`.envrc`、Codecov token、GitHub token、Apple ID、app-specific password、`MATCH_PASSWORD`、keychain password、signing identity、provisioning profile、証明書は機密。雛形以外は commit しない。

`Reports/`、coverage report、Swift-DocC 生成物、Fastlane metadata、スクリーンショット、配布設定は公開範囲と機密性を確認してから変更する。

## 外部生成物

Codex / Claude の plugin・skill・cache・marketplace 由来ファイルは直接編集しない。

対象例:

- `~/.agents/skills/*`
- `~/.codex/skills/*`
- `~/.codex/plugins/cache/*`
- `~/.claude/plugins/cache/*`

挙動を変えたい場合は、設定・overlay・fork・upstream 反映のどれで扱うかを先に確認する。
