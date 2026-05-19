# project_xcode26_spm_migration

Xcode 26.5 / iOS 15-26 対応と SPM 移行の作業記録。

## 方針

- Library 配布とテスト依存は Swift Package Manager に一本化する。
- Carthage / CocoaPods の直接サポートは撤去する。
- `fastlane` は task runner として残す。CocoaPods / Carthage lane は削除する。
- Swift language mode は初期移行では Swift 5 mode を維持し、Swift 6 strict concurrency は別 phase に回す。

## 実施内容

- `Package.swift` / `Package.resolved` を追加し、iOS 15 minimum、Quick 7.6.2、Nimble 14.0.0 に更新。
- Xcode project の deployment target を 15.0、upgrade metadata を Xcode 26 系に更新。
- Xcode project から Carthage framework refs / copy-framework script phase を削除し、Quick / Nimble を SPM package product に置換。
- `Cartfile*`, `Fluidable.podspec`, `.travis.yml` を削除。
- `Gemfile` は `fastlane` のみに整理し、Jazzy / Slather / CocoaPods 系の直接依存を撤去。
- `.mise.toml` を追加し、Ruby 4.0.4 / Python 3.14.5 / SwiftLint 0.63.2 を固定。
- `fastlane/Fastfile` は SwiftPM build、Xcode unit tests、SwiftLint、DocC、xccov coverage、cleanup のみに整理。
- `fastlane ios create_doc` は Swift-DocC で static hosting docs を生成する。`docs/` は DocC 生成物専用とし、memory / superpowers は `.agents/` 配下へ移動。
- `fastlane ios coverage` は Slather を使わず、coverage enabled test の `.xcresult` から `xcrun xccov view --report` で `Reports/coverage/xccov.txt` を生成する。
- `README.md`, `.gitignore`, `.swiftlint.yml`, GitHub Actions workflow を SPM 前提に更新。
- GitHub Actions は `xccov.txt` を `codecov/codecov-action@v6` で upload し、Codecov badge を継続利用する。
- `docs/` の Jazzy 生成物を DocC 生成物に置換し、公開 docs の古い Carthage / CocoaPods 表記を撤去。
- Swift source / tests は Xcode 26.5 / Swift 6.3 compiler で通るように import、retroactive conformance、deprecated API、Quick 7 API を修正。

## Verification

- `mise exec -- ruby --version` -> Ruby 4.0.4。
- `mise exec -- python --version` -> Python 3.14.5。
- `swift package describe` -> pass。
- `swift build --sdk <iPhoneSimulator26.5.sdk> --triple arm64-apple-ios15.0-simulator` -> pass。
- `xcodebuild build -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO` -> pass。
- `xcodebuild build-for-testing -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO` -> pass。
- `xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' -only-testing:FluidableTests CODE_SIGNING_ALLOWED=NO` -> 79 tests, 0 failures。
- `xcodebuild build -project Fluidable.xcodeproj -scheme Fluidable -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO IPHONEOS_DEPLOYMENT_TARGET=15.0` -> pass。
- `xcodebuild build -project Fluidable.xcodeproj -scheme FluidableExample -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO` -> pass。
- `mise exec -- bundle exec fastlane ios coverage` -> pass。79 tests, 0 failures。`Reports/coverage/xccov.txt` を生成。Coverage 17.71%。
- `mise exec -- bundle exec fastlane ios test` -> pass。SwiftPM build-for-testing、coverage、SwiftLint まで通過。SwiftLint は 152 warnings / 0 serious。
- `mise exec -- bundle exec fastlane ios create_doc` -> pass。既存 source comment warning あり。
- `git diff --check` -> pass。

## 残リスク

- Full UI test 実行は legacy UI specs の長時間待機があり、現時点では gate にしていない。`build-for-testing` で UI test bundle の compile は確認済み。
- Codecov は GitHub Actions 上での upload 検証が必要。現状は OIDC (`id-token: write`, `use_oidc: true`) 前提。
- Nimble `Package.swift` の deprecated initializer warning は外部ライブラリ由来なので放置。
- SwiftLint warning は既存 style debt として残る。CI gate は exit code 0 / 0 serious を基準にしている。
