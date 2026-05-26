[![CI](https://github.com/gumob/Fluidable/actions/workflows/ci.yml/badge.svg)](https://github.com/gumob/Fluidable/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/gumob/Fluidable/branch/main/graph/badge.svg)](https://codecov.io/gh/gumob/Fluidable)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
![Language](https://img.shields.io/badge/Language-Swift%205-orange.svg)

# Fluidable
A Swift library that allows you to create a custom transition conforming to Fluid Interfaces.

## Features & To-Do
- [x] Support `UINavigationControllerDelegate` and `UIViewControllerTransitioningDelegate`
- [x] Interactive and interruptible transition with `UIScrollView`, `UITableView`, and `UICollectionView`
- [x] Additional animations for view controllers that can be defined in the delegate method (supports both `UIViewPropertyAnimator` and `Core Animation`)
- [x] Monitor transition states and progress with delegate methods
- [x] Customizable presentation style (Fluid, Drawer, and Slide)
- [x] Resizable drawer
- [x] Customizable style (rounded corner, shadow, and background effect)
- [x] Customizable animation easing and duration
- [ ] Interact with underlying views like Apple Maps
- [ ] Custom transitions with user-definable plug-ins
- [x] Support iOS 15 or later

Fluid                      |  Drawer                   | Slide
:-------------------------:|:-------------------------:|:-------------------------:
![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/case-01.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/case-04.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/case-08.gif)
![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/case-02.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/case-06.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/case-09.gif)

## Requirements

- iOS 15.0 or later
- Xcode 26 / Swift 6.3 compiler, using Swift 5 language mode

## Installation

Fluidable is distributed with Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/gumob/Fluidable.git", from: "2.0.0"),
]
```

## Example application
Repository contains example sources under [Example](https://github.com/gumob/Fluidable/tree/main/Example) directory. Structure of the application is simple, but the project contains multiple UI patterns to showcase capabilities of the library.
You can build an example app by choosing `FluidableExample` from the Xcode schemes.

## Usage

Full documentation is available at [https://gumob.github.io/Fluidable/documentation/fluidable/](https://gumob.github.io/Fluidable/documentation/fluidable/).<br/>
You can find more specific implementations by searching the [Example](https://github.com/gumob/Fluidable/tree/main/Example) sources with "`IMPORTANT: 🌊`".


### Custom transition using [`UIViewControllerTransitioningDelegate`](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate)

1) Import [`Fluidable`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidable) framework to your project files:
```swift
import UIKit
import Fluidable
```

2) Initialize [`Fluidable`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidable) framework in `AppDelegate`:
```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FluidableInit()
      return true
  }
}
```

3) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidable) protocol in the <span style="color:magenta">source</span> view controller:
```swift
class RootViewController: UICollectionViewController, Fluidable {
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.fluidDelegate = self
  }
}
```

4) Conform to [`FluidTransitionSourceConfigurationDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidtransitionsourceconfigurationdelegate) and [`FluidTransitionSourceActionDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidtransitionsourceactiondelegate) protocols in the <span style="color:magenta">source</span> view controller:
```swift
extension RootViewController: FluidTransitionSourceConfigurationDelegate {
  /* Implement delegate methods */
}
extension RootViewController: FluidTransitionSourceActionDelegate {
  /* Implement delegate methods */
}
```

5) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidable) protocol in the <span style="color:magenta">destination</span> view controller:
```swift
class TransitionScrollViewController: TransitionBaseViewController, Fluidable {
  var fluidableTransitionDelegate: FluidViewControllerTransitioningDelegate = FluidViewControllerTransitioningDelegate()
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        self.transitioningDelegate = self.fluidableTransitionDelegate
        self.fluidDelegate = self
  }
}
```

6) Conform to [`FluidTransitionDestinationConfigurationDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidtransitiondestinationconfigurationdelegate) and [`FluidTransitionDestinationActionDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidtransitiondestinationactiondelegate) protocols in the <span style="color:magenta">destination</span> view controller:
```swift
extension TransitionScrollViewController: FluidTransitionDestinationConfigurationDelegate {
  /* Implement delegate methods */
}
extension TransitionScrollViewController: FluidTransitionDestinationActionDelegate {
  /* Implement delegate methods */
}
```


### Custom transition using [`UINavigationControllerDelegate`](https://developer.apple.com/documentation/uikit/uinavigationcontrollerdelegate)

1) Import `Fluidable` framework to your project files:
```swift
import UIKit
import Fluidable
```

2) Initialize `Fluidable` framework in `AppDelegate`:
```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FluidableInit()
      return true
  }
}
```

3) Keep a [`FluidNavigationControllerDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidnavigationcontrollerdelegate) instance alive in the navigation controller, assign it to `delegate`, and conform the navigation controller to [`Fluidable`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidable):
```swift
class NavigationRootNavigationController: UINavigationController, Fluidable {
  let fluidNavigationDelegate = FluidNavigationControllerDelegate()

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.delegate = self.fluidNavigationDelegate
      self.fluidDelegate = self
  }
}
```

4) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidable) protocol in the <span style="color:magenta">source</span> view controller:
```swift
class NavigationScrollViewController: UIViewController, Fluidable {
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.fluidDelegate = self
  }
}
```

5) Conform to [`FluidNavigationSourceConfigurationDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidnavigationsourceconfigurationdelegate) and [`FluidNavigationSourceActionDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidnavigationsourceactiondelegate) protocols in the <span style="color:magenta">source</span> view controller:
```swift
extension NavigationScrollViewController: FluidNavigationSourceConfigurationDelegate {
  /* Implement delegate methods */
}
extension NavigationScrollViewController: FluidNavigationSourceActionDelegate {
  /* Implement delegate methods */
}
```

6) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidable) protocol in the <span style="color:magenta">destination</span> view controller:
```swift
class NavigationChildViewController: UIViewController, Fluidable {
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.fluidDelegate = self
  }
}
```

7) Conform to [`FluidNavigationDestinationConfigurationDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidnavigationdestinationconfigurationdelegate) and [`FluidNavigationDestinationActionDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidnavigationdestinationactiondelegate) protocols in the <span style="color:magenta">destination</span> view controller:
```swift
extension NavigationChildViewController: FluidNavigationDestinationConfigurationDelegate {
  /* Implement delegate methods */
}
extension NavigationChildViewController: FluidNavigationDestinationActionDelegate {
  /* Implement delegate methods */
}
```

### Resizable drawer

The [`FluidResizableTransitionDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidresizabletransitiondelegate) is available only for bottom drawer presentations.

1) Conform to [`FluidResizableTransitionDelegate`](https://gumob.github.io/Fluidable/documentation/fluidable/fluidresizabletransitiondelegate) protocol in the <span style="color:magenta">destination</span> view controller:
```swift
class TransitionScrollViewController: TransitionBaseViewController, Fluidable, FluidResizable {
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.transitioningDelegate = self.fluidableTransitionDelegate
      self.fluidDelegate = self
      self.fluidResizableDelegate = self
  }
}

extension TransitionScrollViewController: FluidResizableTransitionDelegate {
    func transitionShouldPerformResizing() -> Bool { return true }
    func transitionMinimumMarginForResizing() -> CGFloat { return 64 }
    func transitionSnapPositionsForResizing() -> [CGFloat]? { return [0.0, 0.5, 1.0] }
    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {
    }
}
```




## Copyright

Fluidable is released under MIT license, which means you can modify it, redistribute it or use it however you like.

All image embedded in the example project are downloaded from [Pexels](https://www.pexels.com/royalty-free-images/).
