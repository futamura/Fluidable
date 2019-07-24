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

Read the [API reference](https://gumob.github.io/Fluidable/Core.html) and the [USAGE.md](https://gumob.github.io/Fluidable/usage.html) for detailed information.

## Copyright

Fluidable is released under MIT license, which means you can modify it, redistribute it or use it however you like.

All image embedded in the example project are downloaded from [Pexels](https://www.pexels.com/royalty-free-images/).
