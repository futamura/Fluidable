# CODING-GUIDE.md

本ファイルは本リポジトリ (`Fluidable`) を扱う際の共通作業指針。coding agent は各 entrypoint から本ファイルを参照する。

全プロジェクト横断のグローバルルールは、各 agent の entrypoint / global instruction を参照。

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

## セッション構成

agent session の起動位置は repo-root (`Fluidable/`) 固定。

- 新規セッション開始時は、着手前に `pwd` で CWD が repo-root か確認する。
- `Example/`, `Sources/`, `Tests/`, `docs/`, `.agents/` などの配下で開始していた場合は、作業を進めず、repo-root での再開を促す。
- CWD 基準書込みと git repo-root 基準書込みが分裂しないよう、project file / memory / docs / generated output は repo-root 基準の path で扱う。

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

## Agent 運用ポリシー

自律的に進められる場面でも以下は必ずユーザー確認を取る。

1. memory または project doc に「新規セッション推奨」と明記された task は、本セッションで着手せず、引き継ぎ内容を提示して終了する。
2. 推論 effort や実行方針を大きく切り替える場合は、phase 内容の承諾を取り直す。
3. ブランチ作成後、作業開始前にユーザー承諾を得る。
4. コンテキスト肥大化、同一 bug の複数回失敗、tool error の連続、指示の一部忘却を検知したら次 task に入らず、新規セッション移行を提案する。

自律実行は lint 修正、typo 修正、明らかな format 修正などの routine 判断に限る。project 規律の越権は routine ではなく違反として扱う。

### Reasoning Level / Effort Gate

- effort はユーザー手動操作。agent は必要時に提案する。
- 各 phase 開始前に、現在 level と推奨 level を確認する。現在 level が不明な場合は `unknown` とする。
- 現在 level と推奨 level が不一致、または現在 level が `unknown` の場合は、切替を促し、ユーザー応答を待つ。
- 目安は、bootstrap / scope 確認は `medium`、要件整理 / 仕様判断 / plan は `high`、実装は `medium`、bug 原因調査 / verification failure は `high` 以上。
- 失敗後の再分析、新情報取得時、仮説転換時は effort を再評価する。

### セッション区切りと新規セッション推奨

以下の兆候が出たら区切りの良い所で作業を止め、新規セッション移行を提案する。

- 同じ file の 3 回以上の再読込、tool call error 連続、指示の一部忘却、長文内で前後矛盾。
- 同一 bug の修正が 2 回以上失敗。
- 複数 task 完了済み、PR merge 済み、commit 5 件以上、tool call が多く文脈が肥大化。

提案時は branch 状態、残 task、制約、既出の決定事項を含む自己完結な引き継ぎメモを提示する。

## セッション初期プロトコル

新規タスク着手前に以下を 1 メッセージで提示し、ユーザー承諾を得てから実装・ブランチ作成・ファイル編集に入る。

1. タスク分類: 調査 / ドキュメント / バグ修正 / 機能追加 / リファクタ
2. 適用 skill: 必要なもののみ列挙
3. effort level: 現在 level と推奨 level。不一致なら切替依頼。不明なら `unknown`
4. ブランチ運用: 新規ブランチ要否、prefix 候補、ブランチ名候補
5. 作業フェーズ: 調査 -> 設計 -> 計画 -> 実装 -> verification -> commit / PR
6. 確認 checkpoint: 方針変更、scope 変更、破壊的操作、認証情報、署名、課金 API、権限変更、commit / PR / merge / branch deletion
7. 完了後フロー: commit -> push -> PR -> merge -> local branch switch まで一括実行するか

ユーザーの発言が質問形式の場合、作業前にまず回答する。短い返答 (`OK`, `了解`, `進めて`) は直前 checkpoint の承認に限る。

この 7 項目には、Verification Gate / 関連 memory / 対象 task から抽出した必須 verification gate を含める。

## Superpowers Workflow

実装・修正・挙動変更・重要な docs policy 変更では、superpowers workflow を必須とする。

通常 sequence:

1. session bootstrap を行う。
2. ユーザー発言が質問なら、作業開始前にまず回答する。
3. 必要な skill を読む。
4. 初期プロトコルを提示し、承認を待つ。
5. 承認後、必要なら `develop` から作業ブランチを作る。
6. ブランチ作成後、作業内容と方針を再確認して承認を待つ。
7. `superpowers:brainstorming` で要件と代替案を整理する。
8. design / 方針を提示し、承認を待つ。
9. 必要に応じて spec を作成し、self-review 後にユーザー確認を依頼する。
10. `superpowers:writing-plans` で implementation plan を作成し、self-review 後にユーザー確認を依頼する。
11. ここで停止し、明示的な implementation start 指示を待つ。
12. implementation start 後は承認済み plan に沿って進める。
13. plan と本 guide の上位 gate に従って verification を行う。plan が上位 gate を省略・弱体化している場合は plan を修正し、本 guide を優先する。
14. memory へ影響する task では `.agents/memory/MEMORY.md` を更新する。
15. Commit Preflight と Commit Gate を通過した場合のみ commit する。
16. push / PR / merge / branch deletion は承認済み completion flow に従う。

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

### Verification Gate Derivation

spec / plan / 作業方針作成時、Verification Gate、関連 memory gotcha、対象 task から必須 verification gate を抽出し、Verification section または作業方針に明記する。

上位ルール上必須の gate を `optional` / `必要なら` / `可能なら` / `できれば` と弱めてはならない。必須 gate を省いた spec / plan は未完成として扱い、実装・commit に進まない。

Example app の transition / layout / gesture / animation / Storyboard / Auto Layout / asset / font に影響する変更では、Simulator または実機で確認する checklist を作る。ユーザーが確認する場合も、commit 前に `user verified OK` として checklist に記録する。

### Commit Preflight

commit 前に必ず以下を確認する。

1. 変更内容が Simulator / 実機確認対象か判定する。
2. 対象なら spec / plan / 作業メモに確認 checklist があることを確認する。
3. 各 checklist item が `OK` / `user verified OK` / `issue fixed` で埋まっていることを確認する。
4. lint / build / test / docs generation など plan に定義された non-visual verification が完了していることを確認する。
5. 未実施・未記録の必須 gate がある場合は commit しない。
6. plan がこの gate を省略していても、`CODING-GUIDE.md` を優先する。

commit 後に必須 gate 漏れが発覚した場合は、次作業へ進まず、漏れた gate の実施・記録・必要な docs 修正を先に行う。

## Commit Gate

`git commit` 前に必ずユーザー承認を得る。一括承認がない限り、編集・検証の承認を commit 承認と解釈しない。

commit 承認前に提示する内容:

1. commit 対象 file list
2. staged / unstaged / untracked 状態
3. verification 結果
4. UI / 実機確認が必要な場合は checklist 結果
5. commit message 案

commit message は Conventional Commits 寄りにする。例: `docs: add agent guide`, `fix(ios): correct transition state`。`Co-Authored-By` や AI 生成署名は入れない。

Commit Gate では、commit する選択肢を数字付きで提示してよい。直前の Commit Gate で `1. commit する` / `1. 推奨: ... で commit` のように commit action が明示された選択肢に対し、ユーザーが該当番号だけを返した場合、その番号回答を commit 承認として扱う。

番号回答による commit 承認は、直前に提示した Commit Gate の選択肢に限って有効とする。古い選択肢番号や、commit action が明示されていない選択肢番号を commit 承認と解釈しない。

`進めて` / `どうぞ` / `修正よろしく` / `OK` / `了解` は編集・調査・検証の承認であり、commit 承認ではない。番号回答以外で commit するには `commitして` / `コミットOK` / `その内容でcommit` / `commit まで進めて` 等、commit を明示する承認が必要。

例外:

- タスク開始時に「commit まで実行」と明示承認された場合。
- 完了後フローまで一括実行が承認された場合。
- ユーザーが特定 commit message を指定して commit を依頼した場合。

## ブランチと PR

通常 task は `develop` から作業ブランチを切る。`develop` で直接作業しない。小さな docs 修正でも、ユーザーが直接 commit を明示しない限りブランチを提案する。

作業完了後の PR / merge target は原則 `develop`。まとまった更新が完了し、version up / release 公開を行う段階でのみ `main` に merge する。`main` は公開済みまたは公開準備済みの状態を保つ。

`main` は release / public branch 名である。`main` への PR / merge は公開処理が走る可能性があるため、通常 task では行わない。

作業ブランチ -> `develop` は squash merge を基本とする。`develop` -> `main` は release 境界を残すため merge commit を基本とする。

branch prefix は `docs/`, `feature/`, `fix/`, `improve/`, `perf/`, `refactor/`, `upgrade/`, `build/`, `chore/` のいずれかを優先する。ブランチ名は候補を複数提示し、ユーザー承諾後に作成する。ブランチ作成後もすぐに実装に入らず、作業内容と方針をユーザーに確認してから着手する。

作業フェーズごとに区切って commit する。複数フェーズ分の変更を 1 commit にまとめない。各 commit は Commit Gate に従う。

PR には目的、主要変更点、verification、UI 変更時のスクリーンショットまたは実機確認メモ、関連 issue を記載する。

### 完了後フロー

開始時にユーザーが「完了後フローまで一括実行」を承認した場合のみ、作業完了後に `commit -> push -> PR -> mergeability / checks 確認 -> develop squash merge -> local develop switch` まで連続して実行してよい。

一括承認がない場合は、implementation commit 後に停止し、次の処理を確認する。

branch deletion は、completion flow の一括承認があっても自動実行しない。削除対象を提示し、別途ユーザー承認を得てから実行する。

以下の場合は停止してユーザー確認を取る。

- 未承認の scope 変更が必要。
- merge conflict。
- test / lint / build / docs generation failure。
- required checks / GitHub protection により merge が blocked。
- checks failed を確認した。
- unrelated な dirty worktree。
- protected branch / permission / GitHub 側 error。
- `develop` / `main` へ直接 commit が必要になりそうな場合。

### PR Checks / Merge Gate

PR 作成後の checks / merge は base branch ごとに扱いを分ける。

作業ブランチから `develop` への PR は、mergeability / conflict / permission / protection / dirty worktree / unpushed commit / checks 状態を確認する。checks が pass、または checks が存在せず blocked でもない場合のみ、承認済み completion flow に従って `develop` へ squash merge してよい。

checks が pending の場合は状態を報告して待機または停止する。checks が failed の場合は default では merge せず、failure 内容を報告する。ユーザーが `checks を無視して merge` / `このまま merge` 等で明示的に指示した場合のみ、現在の checks 状態を再報告した上で merge してよい。

`develop` から `main` への PR は release / public 境界であるため、required checks を待機する。checks が pass し、ユーザーが merge を承認したら、`main` へ merge commit で統合する。

checks polling 中にユーザーから新しい指示が来た場合、その指示を優先する。`status` 要求なら現在の checks 状態を返して polling を継続する。`merge` 指示なら checks 状態を再確認し、上記の明示 merge 指示として扱う。

### Branch Deletion Gate

PR merge 後も、作業ブランチ削除は自動実行しない。

削除対象 branch と削除範囲を提示し、ユーザーが `branch削除OK` / `delete branch` / `消して` 等で明示承認した場合のみ削除する。

削除範囲は以下を区別する。

- local branch
- remote branch
- local / remote both

### Git Worktree Policy

通常 task は repo-root + 作業ブランチで進める。

大きめ feature / 複数案 / subagent 並列 / 実験で isolation が必要な場合は、作業前に git worktree 利用を提案する。

project-local worktree を使う場合は、作成前に `.worktrees/` が ignore されていることを確認する。

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

project memory の canonical store は `.agents/memory/`。agent 固有の自動 memory 読み込みは前提にせず、session bootstrap で明示的に読む。

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
- branch / PR / commit などの project 運用ルール本文

完了済み project summary は `.agents/memory/archive/` に退避し、`MEMORY.md` には archive file への link と必要最小限の要約だけを残す。詳細な機能固有ログは `project_*.md` に置き、常時参照が不要になったら archive へ移す。

完了済み memory を archive へ移す前に、以下を確認する。

1. 未完了 TODO / next action が残っていない。
2. 今後も必要な技術知見は `gotcha_*` に昇格済み。
3. ユーザー規律・好みは `feedback_*` に昇格済み。
4. branch / PR / commit / spec / plan で履歴を追える。
5. `MEMORY.md` 側に必要な link が残っている。

memory file の分類:

| prefix | type | 性質 | 判定基準 |
| --- | --- | --- | --- |
| `feedback_*` | feedback | ユーザー規律 / 好み | 主語がユーザー。好み、作業規律、応答方針。 |
| `gotcha_*` | feedback | 技術的 gotcha / 非自明挙動 | 主語が機能、library、tool、repo。客観的な挙動や注意点。 |
| `project_*` | project | 特定 task / feature の作業記録 | 特定 task、branch、PR、migration に紐づく進行状態。 |
| `user_*` | user | ユーザー背景 | ユーザー自身の背景情報。 |

新規 memory 作成時は、主語が誰 / 何か、事実か好みかで分類する。技術的側面を含む hybrid な内容は原則 `gotcha_*` に寄せる。ユーザー横断ルールは repo memory に残さず、global instruction へ昇格する。

branch / PR / commit などの project 運用ルール本文は `CODING-GUIDE.md` に置く。`MEMORY.md` には task 状態、短い summary、関連 memory / spec / plan への link だけを置く。

### Memory Commit Timing

memory file は file 種別ごとに commit timing を分ける。

| file 種別 | commit timing | 理由 |
| --- | --- | --- |
| `gotcha_*.md` / `feedback_*.md` の新規追加 | 作業ブランチで PR 前 commit、PR に含める | 永続的な技術知見・ユーザー規律で PR # / merge SHA に依存しない。 |
| `project_*.md` の進行中 task 状態更新 | 作業ブランチに含める | task 中で書いた中間記録であり、作業ブランチが自然な置き場。 |
| `MEMORY.md` の task registry 更新 (`In Progress` / `Backlog` / `Done` 移動、確定済み task 状態) | 原則として作業ブランチで PR 前 commit、PR に含める | ブランチ task は memory の task list 更新まで含めて完了扱いにする。 |
| `MEMORY.md` Done section への PR # / merge SHA / branch deletion / remote rename 等の merge 後にしか確定しない事実追記 | 原則として merge 後に小ブランチを切り、PR 経由で反映する | PR # / merge SHA / branch deletion / remote rename は merge 後または後続操作後に確定する。 |

例外として、`MEMORY.md` の task registry correction だけを更新し、code / CI / project policy / public docs / spec / plan を一切含まない場合に限り、ユーザー明示承認があれば現在の integration branch (`develop` など) へ直接小 commit してよい。この例外でも `git diff --check`、対象 diff の目視、Commit Gate は必須とする。unrelated dirty worktree がある場合は停止する。

### Task Registry / Memory Backlog Policy

`.agents/memory/MEMORY.md` の `Tasks` section は repo の軽量 task registry として扱う。

#### Task ID

`Backlog` / `Icebox` / `Frozen` / `Done` の task は原則 `#NN` 形式の ID を持つ。新規 task を追加する場合は、既存最大番号を `MEMORY.md` と `.agents/memory/archive/*.md` から確認し、次の未使用番号を採番する。

派生 task は必要に応じて `#58a`, `#58b` のように suffix を使ってよい。ただし独立した実装単位なら新しい `#NN` を優先する。

無番号 task を `Backlog` / `Icebox` / `Frozen` に追加してはならない。番号が不明な場合は、追加前に確認する。

#### Task Sections

- `In Progress`: 現在の作業ブランチまたは現在セッションで実行中の task。原則 0-1 件。複数ある場合は理由を書く。
- `Backlog`: 次に拾う可能性が高い未着手 task。上から優先順。
- `Icebox`: 優先度低、拾うか未定の task。順不同。
- `Frozen`: 現時点では進めない task。凍結理由、再開条件、関連 memory / spec / branch を書く。
- `Done`: 完了 task の一時参照。古い完了履歴、常時参照が不要になった完了 task、詳細な完了ログは `.agents/memory/archive/` に移す。

#### Task Lifecycle

新規 task 追加時は以下を含める。

- `#NN` ID
- 短い title
- `YYYY-MM-DD 更新 /` の lifecycle note
- 現在の status section
- why / trigger
- next action
- 関連 spec / plan / project memory があれば link
- branch が存在する場合は branch 名

task entry の基本形式:

```md
- [ ] **#NN タスク名** — YYYY-MM-DD 更新 / 内容...
```

日付はその task entry を最後に実質更新した日を指す。status 移動、内容変更、凍結、再開条件変更、PR / merge 状態追記で更新する。typo / formatting のみなら更新不要。既存 task への日付付与は、その task を触るタイミングで順次行い、一括 backfill はしない。

既存 task に初めて更新日を付与する場合は、以下の優先順で日付を決める。

1. task entry 自体を今回実質更新する場合は、更新日の `YYYY-MM-DD`。
2. 関連 `project_*.md` / spec / plan がある場合は、`git log -1 --format=%cs -- <path>` の日付。
3. 関連 file が未 commit の場合は、現在日付を使い、必要に応じて task entry に未 commit 状態を明記する。
4. 関連 file がない古い task は、entry 内の既存日付または最も近い archive 記録の日付。

filesystem mtime は checkout / format / local touch で変わるため canonical な更新日として使わない。

task を開始したら `Backlog` / `Icebox` から `In Progress` に移す。task が完了したら `Done` に移すか、archive 方針に従って完了記録へ移す。凍結する場合は `Frozen` に移し、凍結理由と再開条件を書く。

ブランチ task は以下が揃うまで完了扱いにしない。

1. 実装 / docs 変更が完了。
2. 必須 verification gate 完了。
3. 必要な memory 更新完了。
4. commit / PR / merge 状態が task entry に反映済み。

## セキュリティと設定

`.envrc`、Codecov token、GitHub token、Apple ID、app-specific password、`MATCH_PASSWORD`、keychain password、signing identity、provisioning profile、証明書は機密。雛形以外は commit しない。

`Reports/`、coverage report、Swift-DocC 生成物、Fastlane metadata、スクリーンショット、配布設定は公開範囲と機密性を確認してから変更する。

## 外部生成物

agent tool の plugin・skill・cache・marketplace 由来ファイルは直接編集しない。

対象例:

- agent-managed skill directory
- agent-managed plugin cache directory
- external installer / marketplace が生成した cache directory

挙動を変えたい場合は、設定・overlay・fork・upstream 反映のどれで扱うかを先に確認する。誤って編集した場合は、編集箇所を明示し、承認後に元へ戻す。
