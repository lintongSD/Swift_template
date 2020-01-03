//
//  AppDelegate.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window =  UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        window?.rootViewController = ETabBarController()
        window?.makeKeyAndVisible()
        
        AppdelegateConfig.config()
        
        return true
    }
    
    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(frame: mainWindow.bounds)
        blurView.effect = UIBlurEffect(style: .light)
        return blurView
    }()
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        window?.addSubview(blurView)
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        blurView.removeFromSuperview()
    }
}

