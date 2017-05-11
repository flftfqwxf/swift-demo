//
//  AppDelegate.swift
//  skypp
//
//  Created by leixianhua on 4/28/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let Rect = UIScreen.main.bounds
        let mainWindow = UIWindow(frame: Rect)
        mainWindow.rootViewController = ViewController()
        window = mainWindow
        window?.makeKeyAndVisible()
        return true
    }

}

