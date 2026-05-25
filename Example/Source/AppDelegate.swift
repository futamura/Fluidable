//
//  AppDelegate.swift
//  Example
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import Fluidable

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /* NOTE: 🌊 Initialize `Fluidable` */
        FluidableInit()
        /* NOTE: Disable border */
        UINavigationBar.appearance().shadowImage = UIImage()
        return true
    }

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
