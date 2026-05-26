## Usage


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
