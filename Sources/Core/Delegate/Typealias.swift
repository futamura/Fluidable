//
//  Typealias.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/** The typealias for `UINavigationController` that conforms to `Fluidable` protocol. */
public typealias FluidNavigationController = Fluidable & UINavigationController
/** The typealias for `UIViewController` that conforms to `Fluidable` protocol. */
public typealias FluidSourceViewController = Fluidable & UIViewController
/** The typealias for `UIViewController` that conforms to `Fluidable` protocol. */
public typealias FluidDestinationViewController = Fluidable & UIViewController

/** The typealias for `UINavigationBar` that conforms to `FluidNavigationBarCompatible` protocol. */
public typealias FluidNavigationBar = FluidNavigationBarCompatible & UINavigationBar

/** The typealias that conforms to `FluidNavigationSourceActionDelegate` protocol. */
public typealias FluidNavigationRootNavigationControllerDelegate = FluidNavigationActionDelegate
/** The typealias that conforms to `FluidNavigationSourceActionDelegate` and `FluidNavigationSourceConfigurationDelegate` protocol. */
public typealias FluidNavigationSourceViewControllerDelegate = FluidNavigationSourceActionDelegate & FluidNavigationSourceConfigurationDelegate
/** The typealias that conforms to `FluidNavigationDestinationActionDelegate` and `FluidNavigationDestinationConfigurationDelegate` protocol. */
public typealias FluidNavigationDestinationViewControllerDelegate = FluidNavigationDestinationActionDelegate & FluidNavigationDestinationConfigurationDelegate

/** The typealias that conforms to `FluidTransitionDestinationActionDelegate` protocol. */
public typealias FluidTransitionRootNavigationControllerDelegate = FluidTransitionActionDelegate
/** The typealias that conforms to `FluidTransitionSourceActionDelegate` and `FluidTransitionSourceConfigurationDelegate` protocol. */
public typealias FluidTransitionSourceViewControllerDelegate = FluidTransitionSourceActionDelegate & FluidTransitionSourceConfigurationDelegate
/** The typealias that conforms to `FluidTransitionDestinationActionDelegate` and `FluidTransitionDestinationConfigurationDelegate` protocol. */
public typealias FluidTransitionDestinationViewControllerDelegate = FluidTransitionDestinationActionDelegate & FluidTransitionDestinationConfigurationDelegate
