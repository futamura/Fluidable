## Usage

Read the [API reference](https://gumob.github.io/Fluidable/Classes/Fluidable.html) and the [USAGE.md](https://gumob.github.io/Fluidable/usage.html) for detailed information.

### Basic Usage

#### Import frameworks to your project

```swift
import RxSwift
import RxCocoa
import Fluidable
```

#### Add Fluidable

Create a Fluidable object.

```swift
// Create a Fluidable object
self.topPullToRefresh = Fluidable(position: .top)
// Add a Fluidable object to UITableView
self.tableView.p2d.addPullToRefresh(self.topPullToRefresh)
```

#### Observe FluidableDelegate

By observing [FluidableDelegate](https://gumob.github.io/Fluidable/Protocols/FluidableDelegate.html), you can watch the state of a Fluidable object. This delegate is get called by the Fluidable object every time its [state](https://gumob.github.io/Fluidable/Enums/FluidableState.html) or scrolling rate is changed.
```swift
// Observe FluidableDelegate
self.topPullToRefresh.rx.action
        .subscribe(onNext: { [weak self] (state: FluidableState, progress: CGFloat, scroll: CGFloat) in
            // Send request if FluidableState is changed to .loading
            switch state {
            case .loading: self?.prepend()
            default:       break
            }
        })
        .disposed(by: self.disposeBag)
```

#### Load and append contents

```swift
self.viewModel.prepend()
              .subscribe(onSuccess: { [weak self] in
                  // Successfully loaded, collapse refresh view immediately
                  self?.tableView.p2d.endRefreshing(at: .top)
              }, onError: { [weak self] (_: Error) in
                  // Failed to load, show error
                  self?.tableView.p2d.failRefreshing(at: .top)
              })
              .disposed(by: self.disposeBag)
```

#### Disable refreshing by binding Boolean value to canLoadMore property

```swift
self.viewModel.canPrepend
        .asDriver()
        .drive(self.topPullToRefresh.rx.canLoadMore)
        .disposed(by: self.disposeBag)
```

#### Dispose Fluidable objects

```swift
override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.tableView.p2d.endAllRefreshing()
    self.tableView.p2d.removeAllPullToRefresh()
}
```

### Advanced Usage

#### About the example project

`Fluidable` allows you flexibly customize a refresh view by inheriting [Fluidable](https://gumob.github.io/Fluidable/Classes/Fluidable.html) and [FluidableView](https://gumob.github.io/Fluidable/Classes/FluidableView.html) classes. Please check [example sources](https://github.com/gumob/Fluidable/blob/master/Example/) for advanced usage.

- [CustomRefresh](https://github.com/gumob/Fluidable/blob/master/Example/CustomRefresh.swift): A class inheriting from `Fluidable`.
- [CustomRefreshView](https://github.com/gumob/Fluidable/blob/master/Example/CustomRefresh.swift): A class inheriting from `FluidableView`. Animation logics are implemented in this class.
- [BaseTableViewController](https://github.com/gumob/Fluidable/blob/master/Example/TableViewController.swift): A view controller that conforms to MVVM architecture.
- [CustomTableViewController](https://github.com/gumob/Fluidable/blob/master/Example/TableViewController.swift): A view controller that creates a `CustomPullToRefresh` instance.
- [TableViewModel](https://github.com/gumob/Fluidable/blob/master/Example/TableViewModel.swift): A view model that manipulates data sources.

#### Build the example app

1. Update Carthage frameworks
```bash
$ carthage update --platform iOS
```
2. Open `Fluidable.xcodeproj`
3. Select the scheme `FluidableExample` from the drop-down menu in the upper left of the Xcode window
4. Press ⌘R
