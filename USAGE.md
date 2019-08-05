## Usage


### Custom transition using [`UIViewControllerTransitioningDelegate`](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate)

1) Import [`Fluidable`](https://gumob.github.io/Fluidable/Protocols/Fluidable.html) framework to your project files:
```swift
import UIKit
import Fluidable
```

2) Initialze [`Fluidable`](https://gumob.github.io/Fluidable/Protocols/Fluidable.html) framework in `AppDelegate`:
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

The [`FluidResizableTransitionDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidResizableTransitionDelegate.html) is available for only bottom drawer.

1) Conform to [`FluidResizableTransitionDelegate`](https://gumob.github.io/Fluidable/Protocols/FluidResizableTransitionDelegate.html) protocol in the <span style="color:magenta">destination</span> view controller:
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
