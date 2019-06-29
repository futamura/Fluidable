//
//  FluidControllerDelegateCompatible.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

protocol FluidControllerDelegateCompatible: NSObjectProtocol {
    associatedtype ViewAnimator: FluidViewAnimatorCompatible
    associatedtype PresentDriver: FluidPresentDriverCompatible
    associatedtype DismissDriver: FluidDismissDriverCompatible

    var viewAnimator: ViewAnimator { get set }
    var presentDriver: PresentDriver { get set }
    var dismissDriver: DismissDriver { get set }

    func dispose()
}
