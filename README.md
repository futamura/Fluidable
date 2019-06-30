[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/gumob/Fluidable)
[![Version](http://img.shields.io/cocoapods/v/Fluidable.svg)](http://cocoadocs.org/docsets/Fluidable)
[![Platform](http://img.shields.io/cocoapods/p/Fluidable.svg)](http://cocoadocs.org/docsets/Fluidable)
[![Build Status](https://travis-ci.com/gumob/Fluidable.svg?branch=master)](https://travis-ci.com/gumob/Fluidable)
[![codecov](https://codecov.io/gh/gumob/Fluidable/branch/master/graph/badge.svg)](https://codecov.io/gh/gumob/Fluidable)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
![Language](https://img.shields.io/badge/Language-Swift%204.2-orange.svg)
![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)

# Fluidable
The Swift library that allows you to create a custom transition conforming to Fluid Interfaces.

<!--
<img src="https://raw.githubusercontent.com/gumob/Fluidable/master/Metadata/screenshot-animation.gif" alt="drawing" width="240px" style="width:240px;"/>

## Features

- Support UIScrollView, UITableView, and UICollectionView
- Customizable refresh view
- Customizable animaton options
- Configurable option whether to load while dragging or to load after an user release a finger
- Error handling
- Support RxSwift/RxCocoa
-->

## Requirements

- iOS 10.0 or later
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
platform :ios, '10.0'
use_frameworks!

pod 'Fluidable'
```

## Usage

Read the [API reference](https://gumob.github.io/Fluidable/Classes/Fluidable.html) and the [USAGE.md](https://gumob.github.io/Fluidable/usage.html) for detailed information.

## Copyright

Fluidable is released under MIT license, which means you can modify it, redistribute it or use it however you like.

All image embedded in the example project are downloaded from [Pexels](https://www.pexels.com/royalty-free-images/).
