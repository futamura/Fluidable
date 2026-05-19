# Xcode 26 SPM Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fluidable を Xcode 26 / iOS 15-26 対応の Swift Package Manager first library に移行し、Carthage / CocoaPods 配布と Ruby 依存の release flow を撤去する。

**Architecture:** `Sources/` を SPM library target、`Tests/` を SPM test target として package root から公開する。既存 Xcode project は Example app / UI tests / visual verification 用に残し、dependency 管理は SPM に一本化する。Swift language mode は初期移行で Swift 5 mode に固定し、Swift 6 mode / strict concurrency は別 phase で扱う。

**Tech Stack:** Xcode 26.5, Swift 6.3 compiler, Swift Package Manager, UIKit, XCTest, Quick 7+, Nimble 14+, SwiftLint 0.63+, mise, Ruby 4.0.4, Python 3.14.5, GitHub Actions。

---

## 前提

- 作業 branch: `build/xcode26-spm-migration`
- 現状 branch での調査結果:
  - Xcode: `26.5 (17F42)`
  - SDK: `iphoneos26.5`, `iphonesimulator26.5`
  - Swift compiler: `Apple Swift version 6.3.2`
  - `IPHONEOS_DEPLOYMENT_TARGET = 10.0`
  - `SWIFT_VERSION = 5.0`
  - `LastUpgradeCheck = 1150`
  - `.ruby-version = 2.6.5`
  - `Gemfile.lock`: Bundler 2.1.4, CocoaPods 1.8.4, Fastlane 2.150.1, Jazzy 0.13.4
  - `Cartfile.resolved`: Quick 3.0.0, Nimble 8.1.1, AutoMate 1.7.1
  - `Fluidable.podspec`: `s.swift_version = "5.0"`, `s.ios.deployment_target = "10.0"`
- 2026-05-19 時点の version source:
  - Ruby: `4.0.4`。Ruby 公式 release note: https://www.ruby-lang.org/en/news/2026/05/11/ruby-4-0-4-released/
  - Python: `3.14.5`。Python 公式 release page: https://www.python.org/downloads/release/python-3145/
  - GitHub Actions `macos-26`: Xcode 26.5 path `/Applications/Xcode_26.5.app`。Runner image release: https://newreleases.io/project/github/actions/runner-images/release/macos-26%2F20260512.0101
  - Quick latest release: `7.6.2`。GitHub releases: https://github.com/Quick/Quick/releases
  - Nimble latest release: `14.0.0`。GitHub releases: https://github.com/Quick/Nimble/releases
- Xcode 26 診断結果:
  - 通常 build は Swift frontend crash。`COMPILER_INDEX_STORE_ENABLE=NO` で crash は回避。
  - 次 blocker は `/usr/local/bin/carthage: No such file or directory`。
  - Warnings: deprecated `protocol: class`, retroactive conformance, `UIUserInterfaceIdiom.mac/vision`, `CALayer.hidden`, deployment target 10.0。

## 対象ファイル

- Create: `Package.swift`
- Create: `.mise.toml`
- Create: `.github/workflows/ci.yml`
- Modify: `Fluidable.xcodeproj/project.pbxproj`
- Modify: `Fluidable.xcodeproj/xcshareddata/xcschemes/Fluidable.xcscheme`
- Modify: `Fluidable.xcodeproj/xcshareddata/xcschemes/FluidableExample.xcscheme`
- Modify: `.envrc`
- Modify: `fastlane/Fastfile`
- Modify: `Gemfile`
- Modify: `Gemfile.lock`
- Modify: `README.md`
- Modify: `USAGE.md`
- Modify: `.gitignore`
- Modify: `Sources/View/FluidInteractiveView.swift`
- Modify: `Sources/Helper/AdaptiveLayout/Protocols/AdaptiveInterface.swift`
- Modify: `Sources/Helper/Extension/UIKit+Ext.swift`
- Modify: `Sources/Helper/Extension/QuartzCore+Ext.swift`
- Modify: `Sources/Helper/AdaptiveLayout/Extensions/UITraitCollection+Adaptive.swift`
- Modify: `Sources/Helper/Animations/CoreAnimation/FluidCoreAnimatorKeyPath.swift`
- Modify: `Sources/Core/Parameter/Protocol/FluidParametersAccessible.swift`
- Modify: `UITests/MainSpec.swift`
- Modify: `UITests/MainSpec+Transition.swift`
- Delete: `Cartfile`
- Delete: `Cartfile.private`
- Delete: `Cartfile.resolved`
- Delete: `Carthage/`
- Delete: `Fluidable.podspec`
- Delete: `.ruby-version`
- Delete: `UITests/AutoMate+Ext.swift`
- Delete: `.travis.yml`

## Verification Gate

- Package manifest: `swift package describe`
- SPM build: `swift build`
- SPM unit tests: `swift test`
- Xcode framework build: `xcodebuild build -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO`
- Xcode test: `xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO`
- Minimum deployment build: `xcodebuild build -project Fluidable.xcodeproj -scheme Fluidable -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO IPHONEOS_DEPLOYMENT_TARGET=15.0`
- Example build: `xcodebuild build -project Fluidable.xcodeproj -scheme FluidableExample -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO`
- UI smoke: iOS 26.5 simulator で `FluidableExample` を起動し、drawer / slide / fluid modal の present / dismiss / rotate を確認する。
- Optional runtime smoke: iOS 15.x simulator runtime が local / CI にある場合のみ、iOS 15.x で Example smoke を追加実行する。Xcode 26 runner image は古い iOS 15 runtime を標準同梱しないため、必須 gate にはしない。
- Lint: `swiftlint lint --config .swiftlint.yml`
- Docs only updates included: `git diff --check`

## Task 1: 作業 branch と baseline 固定

**Files:**
- Modify: none

- [ ] **Step 1: 作業 branch 作成**

Run:

```bash
git switch master
git pull --ff-only
git switch -c build/xcode26-spm-migration
```

Expected:

```text
Switched to a new branch 'build/xcode26-spm-migration'
```

- [ ] **Step 2: clean worktree 確認**

Run:

```bash
git status --short
```

Expected: no output。

- [ ] **Step 3: baseline command 記録**

Run:

```bash
xcodebuild -version
```

Expected:

```text
Xcode 26.5
Build version 17F42
```

- [ ] **Step 4: 現状 build failure 再現**

Run:

```bash
xcodebuild build -quiet -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO
```

Expected: FAIL。`Swift frontend` crash または Carthage script failure が出る。

## Task 2: Package.swift 追加

**Files:**
- Create: `Package.swift`
- Test: `swift package describe`

- [ ] **Step 1: Package.swift 未存在を確認**

Run:

```bash
swift package describe
```

Expected: FAIL with `Could not find Package.swift`。

- [ ] **Step 2: Package.swift を追加**

Create `Package.swift`:

```swift
// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Fluidable",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Fluidable",
            targets: ["Fluidable"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "7.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "14.0.0"),
    ],
    targets: [
        .target(
            name: "Fluidable",
            path: "Sources",
            exclude: [
                "Fluidable.h",
                "Info.plist",
            ],
            swiftSettings: [
                .swiftLanguageMode(.v5),
            ]
        ),
        .testTarget(
            name: "FluidableTests",
            dependencies: [
                "Fluidable",
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble"),
            ],
            path: "Tests",
            exclude: [
                "Info.plist",
            ],
            swiftSettings: [
                .swiftLanguageMode(.v5),
            ]
        ),
    ]
)
```

- [ ] **Step 3: manifest parse 確認**

Run:

```bash
swift package describe
```

Expected: PASS。`products` に `Fluidable`、`targets` に `Fluidable` / `FluidableTests` が出る。

- [ ] **Step 4: package resolution 確認**

Run:

```bash
swift package resolve
```

Expected: PASS。`Package.resolved` が生成され、Quick 7 系、Nimble 14 系以上が記録される。

## Task 3: SPM build failure を先に直す

**Files:**
- Modify: `Sources/View/FluidInteractiveView.swift`
- Modify: `Sources/Helper/AdaptiveLayout/Protocols/AdaptiveInterface.swift`
- Modify: `Sources/Helper/Extension/UIKit+Ext.swift`
- Modify: `Sources/Helper/AdaptiveLayout/Extensions/UITraitCollection+Adaptive.swift`
- Modify: `Sources/Helper/Animations/CoreAnimation/FluidCoreAnimatorKeyPath.swift`
- Modify: `Sources/Core/Parameter/Protocol/FluidParametersAccessible.swift`
- Test: `swift build`

- [ ] **Step 1: SPM build failure 再現**

Run:

```bash
swift build
```

Expected: FAIL。Swift 6.3 compiler diagnostics を読む。初回想定は Xcode build と同じ warnings または `FluidParametersAccessible` 周辺の compiler crash / type diagnostics。

- [ ] **Step 2: class constrained protocol warning 修正**

Change `Sources/View/FluidInteractiveView.swift`:

```swift
public protocol FluidInteractiveView: AnyObject {
```

Change `Sources/Helper/AdaptiveLayout/Protocols/AdaptiveInterface.swift`:

```swift
public protocol AdaptiveInterface: AnyObject, AdaptiveElement {
```

- [ ] **Step 3: retroactive conformance warning 修正**

In `Sources/Helper/Extension/UIKit+Ext.swift`, change these extension declarations:

```swift
extension UINavigationController.Operation: @retroactive CustomStringConvertible {
extension UIBarPosition: @retroactive CustomStringConvertible {
extension NSLayoutConstraint.Attribute: @retroactive CustomStringConvertible {
extension UIGestureRecognizer.State: @retroactive CustomStringConvertible {
extension UIInterfaceOrientation: @retroactive CustomStringConvertible {
extension UIDeviceOrientation: @retroactive CustomStringConvertible {
extension UIModalPresentationStyle: @retroactive CustomStringConvertible {
extension UIUserInterfaceIdiom: @retroactive CustomStringConvertible {
extension UITimingCurveType: @retroactive CustomStringConvertible {
extension UIViewAnimatingPosition: @retroactive CustomStringConvertible {
extension UIViewAnimatingState: @retroactive CustomStringConvertible {
extension UIRectCorner: @retroactive CustomStringConvertible {
extension UIRectEdge: @retroactive CustomStringConvertible {
```

In `Sources/Helper/Extension/QuartzCore+Ext.swift`, change:

```swift
extension CATransform3D: @retroactive Equatable {
```

- [ ] **Step 4: UIUserInterfaceIdiom exhaustive switch 修正**

In `Sources/Helper/Extension/UIKit+Ext.swift`, use:

```swift
extension UIUserInterfaceIdiom: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .phone:       return "phone"
        case .pad:         return "pad"
        case .carPlay:     return "carPlay"
        case .tv:          return "tv"
        case .mac:         return "mac"
        case .vision:      return "vision"
        case .unspecified: return "unspecified"
        @unknown default:  return "unknown"
        }
    }
}
```

In `Sources/Helper/AdaptiveLayout/Extensions/UITraitCollection+Adaptive.swift`, use:

```swift
switch userInterfaceIdiom {
case .pad: attributes.append(Idiom.pad)
case .phone: attributes.append(Idiom.phone)
case .tv: attributes.append(Idiom.tv)
case .carPlay: attributes.append(Idiom.carPlay)
case .mac: break
case .vision: break
case .unspecified: break
@unknown default: break
}
```

- [ ] **Step 5: CALayer key path warning 修正**

Change `Sources/Helper/Animations/CoreAnimation/FluidCoreAnimatorKeyPath.swift`:

```swift
public static var hidden: FluidCoreAnimatorPath<Bool> { return FluidCoreAnimatorPath<Bool>(keyPath: #keyPath(CALayer.isHidden)) }
```

- [ ] **Step 6: Swift frontend crash root 修正**

In `Sources/Core/Parameter/Protocol/FluidParametersAccessible.swift`, remove `weak` from computed properties in protocol extension. Computed properties do not own references; adding `weak` to a computed associated-type property triggers the Xcode 26 indexer crash path.

Use:

```swift
var context: UIViewControllerContextTransitioning? { return self.parameters.context }

var controllerDelegate: ControllerDelegate? { return self.parameters?.controllerDelegate as? ControllerDelegate }

var rootNavigationController: FluidNavigationController? { return self.parameters.rootNavigationController }
var sourceViewController: FluidSourceViewController! { return self.parameters.sourceViewController }
var destinationViewController: FluidDestinationViewController! { return self.parameters.destinationViewController }

var transitionContainerView: UIView! { return self.parameters.transitionContainerView }
var sourceView: UIView! { return self.parameters.sourceView }
var destinationView: UIView! { return self.parameters.destinationView }
var layoutContainerView: UIView! { return self.parameters.layoutContainerView }
```

- [ ] **Step 7: SPM build 確認**

Run:

```bash
swift build
```

Expected: PASS。

## Task 4: SPM unit tests を通す

**Files:**
- Modify: `Tests/*.swift`
- Test: `swift test`

- [ ] **Step 1: SPM test failure 再現**

Run:

```bash
swift test
```

Expected: FAIL または PASS。FAIL の場合は module import / Quick discovery / API compatibility diagnostics を読む。

- [ ] **Step 2: Quick/Nimble import の target 解決を確認**

All files in `Tests/` keep this import shape:

```swift
import Quick
import Nimble
@testable import Fluidable
```

If Quick 7 migration diagnostics appear, update `class FooSpec: QuickSpec` to `final class FooSpec: QuickSpec` only where compiler asks for it.

- [ ] **Step 3: SPM unit tests 確認**

Run:

```bash
swift test
```

Expected: PASS。All `Tests/*Spec.swift` specs execute。

## Task 5: Xcode project を iOS 15 / SPM 前提へ更新

**Files:**
- Modify: `Fluidable.xcodeproj/project.pbxproj`
- Modify: `Fluidable.xcodeproj/xcshareddata/xcschemes/Fluidable.xcscheme`
- Modify: `Fluidable.xcodeproj/xcshareddata/xcschemes/FluidableExample.xcscheme`
- Test: `xcodebuild -list -project Fluidable.xcodeproj`

- [ ] **Step 1: deployment target 置換**

In `Fluidable.xcodeproj/project.pbxproj`, replace every:

```text
IPHONEOS_DEPLOYMENT_TARGET = 10.0;
```

with:

```text
IPHONEOS_DEPLOYMENT_TARGET = 15.0;
```

- [ ] **Step 2: Xcode upgrade marker 更新**

In `Fluidable.xcodeproj/project.pbxproj`, replace:

```text
LastUpgradeCheck = 1150;
```

with:

```text
LastUpgradeCheck = 2650;
```

- [ ] **Step 3: Carthage build phase を project から削除**

Remove these build phases from target `buildPhases` arrays:

```text
A71F679421C54FBD007CADA0 /* Carthage */
A712402721CDCEB200883E13 /* Carthage */
A71F682321C6651D007CADA0 /* Carthage */
```

Remove the matching `PBXShellScriptBuildPhase` entries containing:

```text
shellScript = "/usr/local/bin/carthage copy-frameworks\n";
```

- [ ] **Step 4: Carthage framework references を project から削除**

Remove these `PBXBuildFile` entries:

```text
A712401C21CD43A400883E13 /* Quick.framework in Frameworks */
A712402C21CDCF0300883E13 /* Quick.framework in Frameworks */
A712402E21CE174F00883E13 /* Nimble.framework in Frameworks */
A712403021CE178B00883E13 /* Nimble.framework in Frameworks */
A74186B722D3129800C8DACE /* AutoMate.framework in Frameworks */
```

Remove these `PBXFileReference` entries:

```text
A712401821CD43A400883E13 /* Quick.framework */
A712402D21CE174F00883E13 /* Nimble.framework */
A74186B622D3129800C8DACE /* AutoMate.framework */
```

Remove these IDs from `PBXFrameworksBuildPhase.files` and `PBXGroup.children`:

```text
A712401821CD43A400883E13
A712402D21CE174F00883E13
A74186B622D3129800C8DACE
```

- [ ] **Step 5: Quick / Nimble を Xcode project の Swift Package dependency として追加**

In `PBXBuildFile section`, add package product build files for `FluidableTests` and `FluidableUITests`:

```text
F26000000000000000000007 /* Quick in Frameworks */ = {isa = PBXBuildFile; productRef = F26000000000000000000003 /* Quick */; };
F26000000000000000000008 /* Nimble in Frameworks */ = {isa = PBXBuildFile; productRef = F26000000000000000000004 /* Nimble */; };
F26000000000000000000009 /* Quick in Frameworks */ = {isa = PBXBuildFile; productRef = F26000000000000000000005 /* Quick */; };
F2600000000000000000000A /* Nimble in Frameworks */ = {isa = PBXBuildFile; productRef = F26000000000000000000006 /* Nimble */; };
```

In `PBXFrameworksBuildPhase section`, add these to `A71F674B21C50EA8007CADA0 /* Frameworks */` for `FluidableTests`:

```text
F26000000000000000000007 /* Quick in Frameworks */,
F26000000000000000000008 /* Nimble in Frameworks */,
```

Add these to `A71F680421C6624A007CADA0 /* Frameworks */` for `FluidableUITests`:

```text
F26000000000000000000009 /* Quick in Frameworks */,
F2600000000000000000000A /* Nimble in Frameworks */,
```

In target `A71F674D21C50EA8007CADA0 /* FluidableTests */`, add `packageProductDependencies` before `productName`:

```text
packageProductDependencies = (
    F26000000000000000000003 /* Quick */,
    F26000000000000000000004 /* Nimble */,
);
```

In target `A71F680621C6624A007CADA0 /* FluidableUITests */`, add:

```text
packageProductDependencies = (
    F26000000000000000000005 /* Quick */,
    F26000000000000000000006 /* Nimble */,
);
```

In `PBXProject section`, add `packageReferences` before `productRefGroup`:

```text
packageReferences = (
    F26000000000000000000001 /* XCRemoteSwiftPackageReference "Quick" */,
    F26000000000000000000002 /* XCRemoteSwiftPackageReference "Nimble" */,
);
```

Add new package reference sections near the end of the objects dictionary, outside the existing `PBXProject section`:

```text
/* Begin XCRemoteSwiftPackageReference section */
    F26000000000000000000001 /* XCRemoteSwiftPackageReference "Quick" */ = {
        isa = XCRemoteSwiftPackageReference;
        repositoryURL = "https://github.com/Quick/Quick.git";
        requirement = {
            kind = upToNextMajorVersion;
            minimumVersion = 7.0.0;
        };
    };
    F26000000000000000000002 /* XCRemoteSwiftPackageReference "Nimble" */ = {
        isa = XCRemoteSwiftPackageReference;
        repositoryURL = "https://github.com/Quick/Nimble.git";
        requirement = {
            kind = upToNextMajorVersion;
            minimumVersion = 14.0.0;
        };
    };
/* End XCRemoteSwiftPackageReference section */

/* Begin XCSwiftPackageProductDependency section */
    F26000000000000000000003 /* Quick */ = {
        isa = XCSwiftPackageProductDependency;
        package = F26000000000000000000001 /* XCRemoteSwiftPackageReference "Quick" */;
        productName = Quick;
    };
    F26000000000000000000004 /* Nimble */ = {
        isa = XCSwiftPackageProductDependency;
        package = F26000000000000000000002 /* XCRemoteSwiftPackageReference "Nimble" */;
        productName = Nimble;
    };
    F26000000000000000000005 /* Quick */ = {
        isa = XCSwiftPackageProductDependency;
        package = F26000000000000000000001 /* XCRemoteSwiftPackageReference "Quick" */;
        productName = Quick;
    };
    F26000000000000000000006 /* Nimble */ = {
        isa = XCSwiftPackageProductDependency;
        package = F26000000000000000000002 /* XCRemoteSwiftPackageReference "Nimble" */;
        productName = Nimble;
    };
/* End XCSwiftPackageProductDependency section */
```

- [ ] **Step 6: scheme upgrade marker 更新**

In `Fluidable.xcodeproj/xcshareddata/xcschemes/Fluidable.xcscheme` and `Fluidable.xcodeproj/xcshareddata/xcschemes/FluidableExample.xcscheme`, replace:

```xml
LastUpgradeVersion = "1150"
```

with:

```xml
LastUpgradeVersion = "2650"
```

- [ ] **Step 7: Xcode project parse 確認**

Run:

```bash
xcodebuild -list -project Fluidable.xcodeproj
```

Expected: PASS。Schemes include `Fluidable` and `FluidableExample`。

## Task 6: UI tests から AutoMate を撤去

**Files:**
- Modify: `UITests/MainSpec.swift`
- Modify: `UITests/MainSpec+Transition.swift`
- Delete: `UITests/AutoMate+Ext.swift`
- Test: `xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO`

- [ ] **Step 1: AutoMate import 削除**

Remove this line from `UITests/MainSpec.swift` and `UITests/MainSpec+Transition.swift`:

```swift
import AutoMate
```

- [ ] **Step 2: SwipeDirection を local enum に置換**

In `UITests/MainSpec+Transition.swift`, before `extension MainSpec`, add:

```swift
private enum SwipeDirection {
    case up
    case down
    case left
    case right

    func inverted() -> SwipeDirection {
        switch self {
        case .up: return .down
        case .down: return .up
        case .left: return .right
        case .right: return .left
        }
    }
}
```

- [ ] **Step 3: AutoMate extension file 削除**

Delete:

```text
UITests/AutoMate+Ext.swift
```

Remove its file reference from `Fluidable.xcodeproj/project.pbxproj`:

```text
DFABEB9FBFD6C0413F882F50 /* AutoMate+Ext.swift in Sources */
DFABECB466141931C4EE8391 /* AutoMate+Ext.swift */
```

Remove `DFABEB9FBFD6C0413F882F50` from `A71F680321C6624A007CADA0 /* Sources */` files.

- [ ] **Step 4: UI test target compile 確認**

Run:

```bash
xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO
```

Expected: PASS or test runtime failures unrelated to AutoMate import. If runtime failures appear, record failing spec names before code changes。

## Task 7: Carthage / CocoaPods artifacts を削除

**Files:**
- Delete: `Cartfile`
- Delete: `Cartfile.private`
- Delete: `Cartfile.resolved`
- Delete: `Carthage/`
- Delete: `Fluidable.podspec`
- Modify: `README.md`
- Modify: `USAGE.md`
- Modify: `.gitignore`
- Test: `git status --short`

- [ ] **Step 1: Carthage files 削除**

Run:

```bash
git rm Cartfile
git rm Cartfile.private
git rm Cartfile.resolved
git rm -r Carthage
```

Expected: deleted files staged。

- [ ] **Step 2: CocoaPods podspec 削除**

Run:

```bash
git rm Fluidable.podspec
```

Expected: `Fluidable.podspec` deleted。

- [ ] **Step 3: README installation section を SPM に更新**

Use this installation text in `README.md`:

```markdown
## Installation

Fluidable is distributed with Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/gumob/Fluidable.git", from: "1.0.0"),
]
```
```

Remove CocoaPods / Carthage installation blocks from `README.md` and `USAGE.md`。Also remove the Carthage compatibility badge from the top of `README.md`。

- [ ] **Step 4: .gitignore 更新**

Ensure `.gitignore` contains:

```gitignore
.build/
.swiftpm/
DerivedData/
```

- [ ] **Step 5: 削除状態確認**

Run:

```bash
git status --short
```

Expected: deleted Carthage / CocoaPods files and modified docs are visible。

## Task 8: Ruby / fastlane を SPM 補助へ縮小

**Files:**
- Create: `.mise.toml`
- Delete: `.ruby-version`
- Modify: `.envrc`
- Modify: `Gemfile`
- Modify: `Gemfile.lock`
- Modify: `fastlane/Fastfile`
- Test: `mise exec -- ruby --version`

- [ ] **Step 1: mise 設定追加**

Create `.mise.toml`:

```toml
[tools]
ruby = "4.0.4"
python = "3.14.5"
```

- [ ] **Step 2: legacy Ruby version file を削除**

Run:

```bash
git rm .ruby-version
```

Expected: `.ruby-version` deleted。`.mise.toml` が canonical runtime definition になる。

- [ ] **Step 3: .envrc の CocoaPods 前提を削除**

Replace `.envrc` with:

```bash
# Project

export PROJECT_NAME="Fluidable"
export PROJECT_EXAMPLE_NAME="FluidableExample"
export PROJECT_COMPANY="Gumob"
export COMPANY_ID="com.gumob"

export XCODEPROJ_FRAMEWORK="Fluidable.xcodeproj"
export XCODEPROJ_TEST="Fluidable.xcodeproj"
export XCODEPROJ_UITEST="Fluidable.xcodeproj"

export INFO_PLIST_FRAMEWORK="Sources/Info.plist"
export INFO_PLIST_EXAMPLE="Example/Info.plist"
export INFO_PLIST_TEST="Tests/Info.plist"
export INFO_PLIST_UITEST="UITests/Info.plist"

export SCHEME_IOS="Fluidable"
```

- [ ] **Step 4: Gemfile を release helper に縮小**

Use this `Gemfile`:

```ruby
# frozen_string_literal: true

source "https://rubygems.org"

gem "fastlane"
gem "jazzy"
gem "slather"
```

- [ ] **Step 5: bundle lock 更新**

Run:

```bash
mise exec -- bundle update
```

Expected: PASS。`Gemfile.lock` が Ruby 4.0.4 compatible gems へ更新される。If this fails because `fastlane` / `jazzy` / `slather` does not yet support Ruby 4.0.4, stop and report the exact gem conflict instead of downgrading Ruby silently。

- [ ] **Step 6: fastlane から CocoaPods / Carthage lanes 削除**

In `fastlane/Fastfile`, remove these lanes:

```ruby
lane :lint_cocoapods
lane :push_cocoapods
lane :update_carthage
lane :build_carthage
lane :prebuild
```

Remove `version_bump_podspec` calls from `lane :set_version` and `lane :bump_version`.

Keep `test`, `lint`, `coverage`, `create_doc`, cleanup lanes. Change `lane :test` implementation to call:

```ruby
sh("swift test")
sh("xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO")
```

- [ ] **Step 7: fastlane test lane 確認**

Run:

```bash
mise exec -- bundle exec fastlane ios test
```

Expected: PASS。

## Task 9: CI を GitHub Actions + SPM に更新

**Files:**
- Create: `.github/workflows/ci.yml`
- Delete: `.travis.yml`
- Test: `git diff --check`

- [ ] **Step 1: GitHub Actions workflow 追加**

Create `.github/workflows/ci.yml`:

```yaml
name: CI

on:
  pull_request:
  push:
    branches:
      - master

jobs:
  test:
    runs-on: macos-26
    steps:
      - uses: actions/checkout@v5

      - name: Select Xcode
        run: sudo xcode-select -s /Applications/Xcode_26.5.app/Contents/Developer

      - name: Show versions
        run: |
          xcodebuild -version
          swift --version
          xcodebuild -showsdks

      - name: Resolve packages
        run: swift package resolve

      - name: SwiftPM build
        run: swift build

      - name: SwiftPM tests
        run: swift test

      - name: Xcode tests on iOS 26.5
        run: xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO

      - name: Xcode build with iOS 15 deployment target
        run: xcodebuild build -project Fluidable.xcodeproj -scheme Fluidable -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO IPHONEOS_DEPLOYMENT_TARGET=15.0
```

- [ ] **Step 2: Travis config 削除**

Run:

```bash
git rm .travis.yml
```

Expected: `.travis.yml` deleted。

- [ ] **Step 3: workflow syntax 目視確認**

Run:

```bash
git diff --check
```

Expected: no output。

## Task 10: Xcode 26 verification sweep

**Files:**
- Modify: `docs/memory/MEMORY.md`
- Create: `docs/memory/project_xcode26_spm_migration.md`
- Test: all Verification Gate commands

- [ ] **Step 1: full command verification**

Run:

```bash
swift package describe
```

Expected: PASS。

Run:

```bash
swift build
```

Expected: PASS。

Run:

```bash
swift test
```

Expected: PASS。

Run:

```bash
xcodebuild build -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO
```

Expected: PASS。

Run:

```bash
xcodebuild test -project Fluidable.xcodeproj -scheme Fluidable -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO
```

Expected: PASS。

Run:

```bash
xcodebuild build -project Fluidable.xcodeproj -scheme Fluidable -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO IPHONEOS_DEPLOYMENT_TARGET=15.0
```

Expected: PASS。This verifies the project still compiles with the iOS 15.0 minimum deployment target using the Xcode 26 SDK。

Run:

```bash
xcodebuild build -project Fluidable.xcodeproj -scheme FluidableExample -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' CODE_SIGNING_ALLOWED=NO
```

Expected: PASS。

Run:

```bash
swiftlint lint --config .swiftlint.yml
```

Expected: 0 errors。Warnings are accepted only if already documented in `.swiftlint.yml` and unrelated to migration。

Run:

```bash
git diff --check
```

Expected: no output。

- [ ] **Step 2: Example UI smoke**

Run `FluidableExample` on iPhone 17 / iOS 26.5 simulator and verify:

```text
1. root collection appears.
2. fluid modal present / dismiss works.
3. drawer bottom present / interactive dismiss works.
4. slide left present / dismiss works.
5. rotation portrait -> landscape -> portrait keeps visible frame coherent.
```

- [ ] **Step 3: memory 更新**

Create `docs/memory/project_xcode26_spm_migration.md`:

```markdown
# project_xcode26_spm_migration.md

## 概要

Fluidable を Xcode 26 / iOS 15-26 対応へ更新し、配布と依存管理を Swift Package Manager に一本化した。

## 決定

- CocoaPods / Carthage 配布は終了。
- `Package.swift` を canonical package definition とする。
- Swift language mode は初期移行では Swift 5 mode。
- Swift 6 mode / strict concurrency 対応は別 task。

## Verification

- `swift package describe`: PASS
- `swift build`: PASS
- `swift test`: PASS
- `xcodebuild test` iOS 26.5: PASS
- `xcodebuild build` minimum deployment iOS 15.0: PASS
- `FluidableExample` iOS 26.5 smoke: PASS
```

Update `docs/memory/MEMORY.md` Projects section:

```markdown
- [project_xcode26_spm_migration.md](project_xcode26_spm_migration.md) — Xcode 26 / iOS 15-26 / SPM 完全移行。
```

## Commit checkpoint

Before commit, report:

```text
Files changed:
- Package.swift
- Package.resolved
- .mise.toml
- .github/workflows/ci.yml
- Fluidable.xcodeproj/project.pbxproj
- Fluidable.xcodeproj/xcshareddata/xcschemes/Fluidable.xcscheme
- Fluidable.xcodeproj/xcshareddata/xcschemes/FluidableExample.xcscheme
- fastlane/Fastfile
- Gemfile
- Gemfile.lock
- .envrc
- README.md
- USAGE.md
- .gitignore
- Sources/*
- UITests/*
- docs/memory/MEMORY.md
- docs/memory/project_xcode26_spm_migration.md
- deleted Carthage / CocoaPods / Travis files
- deleted .ruby-version

Verification:
- list every command and result from Task 10.

Commit message proposal:
build: migrate package management to SPM
```

Commit only after explicit user approval.

## Self-review

- Spec coverage: Xcode 26 settings, iOS 15-26 support, build warnings, Ruby/Python mise, Swift source compatibility, Carthage/CocoaPods removal, SPM complete migration, CI update, docs update are covered.
- Placeholder scan: no deferred implementation markers.
- Type consistency: package target is `Fluidable`; test target is `FluidableTests`; product dependency names are `Quick` and `Nimble`.
