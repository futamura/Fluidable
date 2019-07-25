[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/gumob/Fluidable)
[![Version](http://img.shields.io/cocoapods/v/Fluidable.svg)](http://cocoadocs.org/docsets/Fluidable)
[![Platform](http://img.shields.io/cocoapods/p/Fluidable.svg)](http://cocoadocs.org/docsets/Fluidable)
[![Build Status](https://travis-ci.com/gumob/Fluidable.svg?branch=master)](https://travis-ci.com/gumob/Fluidable)
[![codecov](https://codecov.io/gh/gumob/Fluidable/branch/master/graph/badge.svg)](https://codecov.io/gh/gumob/Fluidable)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
![Language](https://img.shields.io/badge/Language-Swift%204.2-orange.svg)
![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)

# Fluidable
A Swift library that allows you to create a custom transition conforming to Fluid Interfaces.

## Features & To-Do
- [x] Support `UINavigationControllerDelegate` and `UIViewControllerTransitioningDelegate`
- [x] Interactive and intrruptible transition with `UIScrollView`, `UITableView`, and `UICollectionView`
- [x] Additional animations for view controllers that can be defined in the delegate method (supports both `UIViewPropertyAnimator` and` Core Animation`)
- [x] Monitor transition states and progress with delegate methods
- [x] Customizable presentation style (Fluid, Drawer, and Slide)
- [x] Resizable drawer
- [x] Customizable style (rounded corner, shadow, and background effect)
- [x] Customizable animation easing and duration
- [ ] Interact with underlying views like Apple Maps
- [ ] Custom transitions with user-definable plug-ins

<!--
<img src="https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-fluid-modal.gif" alt="drawing" width="240px" style="width:240px;"/>
<img src="https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-fluid-fullscreen.gif" alt="drawing" width="240px" style="width:240px;"/>
<img src="https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-drawer-bottom.gif" alt="drawing" width="240px" style="width:240px;"/>
<img src="https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-drawer-right.gif" alt="drawing" width="240px" style="width:240px;"/>
<img src="https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-slide-right.gif" alt="drawing" width="240px" style="width:240px;"/>
<img src="https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-slide-bottom.gif" alt="drawing" width="240px" style="width:240px;"/>
-->


Fluid                      |  Drawer                   | Slide
:-------------------------:|:-------------------------:|:-------------------------:
![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-fluid-modal.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-drawer-bottom.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-slide-bottom.gif)
![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-fluid-fullscreen.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-drawer-right.gif)  |  ![](https://media.githubusercontent.com/media/gumob/Fluidable-Metadata/master/Movies/Exports/Fluidable-slide-right.gif)

## Requirements

- iOS 10.0 or later
- Swift 4.2

## Installation

### Carthage

Add the following to your `Cartfile` and follow [these instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

```
github "gumob/Fluidable"
```

### CocoaPods

To integrate Fluidable into your project, add the following to your `Podfile`.

```ruby
platform :ios, '10.0'
use_frameworks!

pod 'Fluidable'
```

## Example application
Repository contains example sources under [Example](https://github.com/gumob/Fluidable/tree/master/Example) directory. Structure of the application is simple, but the project contains mutiple case of UI petterns to showcase capabilities of the library.
You can build an example app by choosing `FluidableExample` from the Xcode schemes.

## Usage

Full documentation is available at [https://gumob.github.io/Fluidable/](https://gumob.github.io/Fluidable/).



### Custom transition using [`UIViewControllerTransitioningDelegate`](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate)

1) Import `Fluidable` framework to your project files:
```swift
import UIKit
import Fluidable
```

2) Initialze `Fluidable` framework in `AppDelegate`:
```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FluidableInit()
      return true
  }
}
```

3) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/Protocols/Fluidable.html) protocol in the <span style="color:magenta">source</span> view controller:
```swift
class RootViewController: UICollectionViewController, Fluidable {
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.fluidDelegate = self
  }
}
```

4) Conform to [`FluidTransitionSourceConfigurationDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionSourceConfigurationDelegate.html) and [`FluidTransitionSourceActionDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionSourceActionDelegate.html) protocols in the <span style="color:magenta">source</span> view controller:
```swift
extension RootViewController: FluidTransitionSourceConfigurationDelegate {
  /* Implement delegate methods */
}
extension RootViewController: FluidTransitionSourceActionDelegate {
  /* Implement delegate methods */
}
```

5) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/Protocols/Fluidable.html) protocol in the <span style="color:magenta">destination</span> view controller:
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

6) Conform to [`FluidTransitionDestinationConfigurationDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionDestinationConfigurationDelegate.html) and [`FluidTransitionDestinationActionDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionDestinationActionDelegate.html) protocols in the <span style="color:magenta">destination</span> view controller:
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

2) Initialze `Fluidable` framework in `AppDelegate`:
```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FluidableInit()
      return true
  }
}
```

3) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/Protocols/Fluidable.html) protocol in the <span style="color:magenta">source</span> view controller:
```swift
class RootViewController: UICollectionViewController, Fluidable {
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.fluidDelegate = self
  }
}
```

4) Conform to [`FluidTransitionSourceConfigurationDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionSourceConfigurationDelegate.html) and [`FluidTransitionSourceActionDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionSourceActionDelegate.html) protocols in the <span style="color:magenta">source</span> view controller:
```swift
extension RootViewController: FluidTransitionSourceConfigurationDelegate {
  /* Implement delegate methods */
}
extension RootViewController: FluidTransitionSourceActionDelegate {
  /* Implement delegate methods */
}
```

5) Conform to [`Fluidable`](https://gumob.github.io/Fluidable/Protocols/Fluidable.html) protocol in the <span style="color:magenta">destination</span> view controller:
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

6) Conform to [`FluidTransitionDestinationConfigurationDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionDestinationConfigurationDelegate.html) and [`FluidTransitionDestinationActionDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidTransitionDestinationActionDelegate.html) protocols in the <span style="color:magenta">destination</span> view controller:
```swift
extension TransitionScrollViewController: FluidTransitionDestinationConfigurationDelegate {
  /* Implement delegate methods */
}
extension TransitionScrollViewController: FluidTransitionDestinationActionDelegate {
  /* Implement delegate methods */
}
```

### Resizable drawer

`FluidResizableTransitionDelegate` is available for only bottom drawer.

1) Conform to [`FluidResizable`](https://gumob.github.io/Fluidable/Protocols/FluidResizable.html) protocol in the <span style="color:magenta">destination</span> view controller:
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
