//
//  AppDelegate.swift
//  project
//
//  Created by EBIZM2 on 2019/8/20.
//  Copyright © 2019 EBIZM2. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window =  UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        window?.rootViewController = ETabBarController()
        window?.makeKeyAndVisible()
        
        AppdelegateConfig.config()
        
        return true
    }
    
}

