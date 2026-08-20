# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2026-08-20

Fluidable now builds in the Swift 6 language mode. Adopting this release
requires source changes in any project that conforms to Fluidable's delegate
protocols or matches on `FluidCoreAnimatorError`.

Minimum requirements are unchanged: iOS 15.0 or later, built with Xcode 26.

### Breaking Changes

#### 1. Delegate protocols and view-facing types are now `@MainActor`

`FluidDelegate` is annotated with `@MainActor`, so every protocol that inherits
from it is main-actor isolated as well:

- `FluidTransitionConfigurationDelegate`
- `FluidTransitionActionDelegate`
- `FluidTransitionSourceConfigurationDelegate`
- `FluidTransitionDestinationConfigurationDelegate`
- `FluidTransitionSourceActionDelegate`
- `FluidTransitionDestinationActionDelegate`
- `FluidNavigationConfigurationDelegate`
- `FluidNavigationActionDelegate`
- `FluidNavigationSourceConfigurationDelegate`
- `FluidNavigationDestinationConfigurationDelegate`
- `FluidNavigationSourceActionDelegate`
- `FluidNavigationDestinationActionDelegate`

The following declarations are annotated directly:

- `FluidResizableTransitionDelegate`
- `FluidNavigationBarCompatible`
- `FluidFrameDimensionCompatible`
- `FluidInteractiveView`
- `FluidBackgroundCompatible`
- `FluidAnimatorCompatible`
- `FluidCoreAnimatorLayerConvertible`
- `AdaptiveElement`
- `AdaptiveInterface`
- `FluidNavigationControllerDelegate`
- `FluidViewControllerTransitioningDelegate`
- `FluidLayout`

Conforming types must be main-actor isolated. `UIViewController` and `UIView`
subclasses already are, so most conformances keep compiling unchanged. A
conformance declared on a type that is not isolated needs an explicit
annotation:

```swift
// Before (2.x)
final class TransitionCoordinator: NSObject, FluidTransitionSourceConfigurationDelegate {
    func transitionPresentationStyle(from source: FluidSourceViewController,
                                     to destination: FluidDestinationViewController,
                                     with navigation: FluidNavigationController?) -> FluidTransitionStyle {
        return .fluid(behavior: .all)
    }
}

// After (3.0.0)
@MainActor
final class TransitionCoordinator: NSObject, FluidTransitionSourceConfigurationDelegate {
    func transitionPresentationStyle(from source: FluidSourceViewController,
                                     to destination: FluidDestinationViewController,
                                     with navigation: FluidNavigationController?) -> FluidTransitionStyle {
        return .fluid(behavior: .all)
    }
}
```

Any access to these types from a non-isolated context now has to hop to the
main actor, for example with `await MainActor.run { ... }` or by marking the
calling function `@MainActor`.

#### 2. `FluidCoreAnimatorError.invalidArgument` carries `String` instead of `Any?`

The `from` and `to` payloads changed from `Any?` to `String` so that the error
is `Sendable`. The values are formatted with `String(describing:)` before the
error is thrown, so the rendered text is unchanged.

```swift
// Before (2.x)
case .invalidArgument(let id, let key, let from, let to):
    print(id, key, String(describing: from), String(describing: to))

// After (3.0.0)
case .invalidArgument(let id, let key, let from, let to):
    print(id, key, from, to)
```

#### 3. `FluidRoundCornerStyle.all` raw value changed from `11` to `15`

`all` was defined as `[.top, .right, .left, .left]`, which omitted `.bottom`
and duplicated `.left`. As a result `all.contains(.bottom)` returned `false`
and its description dropped `bottom`. It is now `[.top, .right, .bottom, .left]`.

```swift
// Before (2.x)
FluidRoundCornerStyle.all.rawValue          // 11
FluidRoundCornerStyle.all.contains(.bottom) // false

// After (3.0.0)
FluidRoundCornerStyle.all.rawValue          // 15
FluidRoundCornerStyle.all.contains(.bottom) // true
```

If you persisted the raw value of `all`, remap `11` to `15` when reading it
back:

```swift
let stored: Int = defaults.integer(forKey: "cornerStyle")
let style: FluidRoundCornerStyle = stored == 11 ? .all : .init(rawValue: stored)
```

#### 4. `roundingCorners` and `maskedCorners` now honour arbitrary combinations

Both accessors matched `self` against the five named constants with a `switch`.
Because `switch` on an `OptionSet` is exact equality, any other combination fell
through to `default` and produced no rounding. They now union the corner sets of
every flag they contain, so combinations that were silently ignored start taking
effect.

```swift
let style: FluidRoundCornerStyle = [.top, .right]

// Before (2.x)
style.roundingCorners  // nil
style.maskedCorners    // []

// After (3.0.0)
style.roundingCorners  // [.topLeft, .topRight, .bottomRight]
style.maskedCorners    // [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
```

`roundingCorners` still returns `UIRectCorner.allCorners` when all four corners
are selected, because `allCorners` has a raw value of `~0` and is not equal to
the union of the four individual corners.

### Added

- `Sendable` conformance for the public value types: `FluidDriverType`,
  `FluidAnimationType`, `FluidBackgroundStyle`, `FluidDriverInteractionType`,
  `FluidNavigationStyle`, `FluidPresentationStyle`, `FluidSlideDirection`,
  `FluidDrawerPosition`, `FluidTransitionStyle`, `FluidGestureDirection`,
  `PennerEasing`, `FluidAnimatorEasing`, `FluidAnimatorState`,
  `FluidInteractionBehavior`, `FluidRoundCornerStyle`, and `FluidGestureAxis`.
- `PrivacyInfo.xcprivacy` privacy manifest, shipped with both the SwiftPM
  resource bundle and the Xcode framework target. Fluidable collects no data
  and uses no required-reason API, so every key is declared empty.

### Changed

- The library, the test target, the example app, and the UI test target all
  build in the Swift 6 language mode.

### Fixed

- `FluidRoundCornerStyle.all` now includes `.bottom`. See breaking change 3.
- `roundingCorners` and `maskedCorners` now round the corners of any flag
  combination instead of only the five named constants. See breaking change 4.

## Earlier releases

Release notes for `2.0.0` and earlier are published on the
[GitHub Releases](https://github.com/futamura/Fluidable/releases) page.

[3.0.0]: https://github.com/futamura/Fluidable/compare/2.0.0...3.0.0
