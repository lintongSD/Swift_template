//
//  ETabBarController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

class ETabBarController: UITabBarController {

    private let homeVC  = HomeController(nibName: "HomeController", bundle: nil)
    private let leftVC  = LeftController(nibName: "LeftController", bundle: nil)
    private let rightVC = RightController(nibName: "RightController", bundle: nil)
    private let mineVC  = MineController()
    
    private let titleArr = ["首页", "产品", "每日", "我的"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vcArr = [homeVC, leftVC, rightVC, mineVC]
        var navArr: Array<ENavigationController> = []
        for item in vcArr {
            let nav = ENavigationController.init(rootViewController: item)
            navArr.append(nav)
        }
        
        self.viewControllers = navArr
        self.tabBar.barTintColor    = .white
        self.tabBar.tintColor       = .themeColor
        
        self.tabBar.backgroundImage     = UIImage()
        self.tabBar.shadowImage         = UIImage()
        self.tabBar.layer.shadowColor   = UIColor.titleColor.cgColor
        self.tabBar.layer.shadowOffset  = CGSize(width: 0, height: -3)
        self.tabBar.layer.shadowOpacity = 0.1
        self.tabBar.isTranslucent       = false
        
        settingTabImage(navArr: navArr)
        
    }
    
    @objc func settingTabImage(navArr: Array<ENavigationController>) {
        
        for (i, item) in navArr.enumerated() {
            let image = UIImage.init(named: "tabbar_\(i+1)_default")//?.withRenderingMode(.alwaysOriginal)
            let selectedImage = UIImage.init(named: "tabbar_\(i+1)_select")//?.withRenderingMode(.alwaysOriginal)
            
            item.tabBarItem = UITabBarItem.init(title: titleArr[i], image: image, selectedImage: selectedImage)
        }
    }
    
}
