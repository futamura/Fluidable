[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/gumob/Fluidable)
[![Version](http://img.shields.io/cocoapods/v/Fluidable.svg)](http://cocoadocs.org/docsets/Fluidable)
[![Platform](http://img.shields.io/cocoapods/p/Fluidable.svg)](http://cocoadocs.org/docsets/Fluidable)
[![Build Status](https://travis-ci.com/gumob/Fluidable.svg?branch=master)](https://travis-ci.com/gumob/Fluidable)
[![codecov](https://codecov.io/gh/gumob/Fluidable/branch/master/graph/badge.svg)](https://codecov.io/gh/gumob/Fluidable)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
![Language](https://img.shields.io/badge/Language-Swift%204.2-orange.svg)
![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)

# Fluidable
A Swift library allows you to create a flexibly customizable pull-to-refresh view supporting RxSwift.

<img src="https://raw.githubusercontent.com/gumob/Fluidable/master/Metadata/screenshot-animation.gif" alt="drawing" width="240px" style="width:240px;"/>

## Features

- Support UIScrollView, UITableView, and UICollectionView
- Customizable refresh view
- Customizable animaton options
- Configurable option whether to load while dragging or to load after an user release a finger
- Error handling
- Support RxSwift/RxCocoa

## Requirements

- iOS 9.0 or later
- Swift 4.2

## Installation

### Carthage

Add the following to your `Cartfile` and follow [these instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

```
github "gumob/Fluidable"
```

Do not forget to include RxSwift.framework and RxCocoa.framework. Otherwise it will fail to build the application.<br/>

<img src="https://raw.githubusercontent.com/gumob/Fluidable/master/Metadata/carthage-xcode-config.jpg" alt="drawing" width="480" style="width:100%; max-width: 480px;"/>

### CocoaPods

To integrate Fluidable into your project, add the following to your `Podfile`.

```ruby
platform :ios, '9.3'
use_frameworks!

pod 'Fluidable'
```

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


## Copyright

Fluidable is released under MIT license, which means you can modify it, redistribute it or use it however you like.

All image embedded in the example project are downloaded from [Pexels](https://www.pexels.com/royalty-free-images/).