//
//  ETabBarController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

class ETabBarController: UITabBarController {
    
    private var baseUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationTool.observer(self, Selector(("addChildVC")), NotificationKey.tabReload)
        
        addChildVC()
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowOpacity = 0.1
    }
    
    func addChildVC() {
        
//        let sb = UIStoryboard.init(name: "Mine", bundle: nil)
//        let mineVC = sb.instantiateViewController(withIdentifier: "MineController")
        
        let vcArr = [HomeController(), LeftController(), RightController(), MineController()]
        let configArr = [["title":"首页",
                          "imageName":"tab_home",
                          "selectedImageName":"tab_home_selected"],
                         ["title":"直播课",
                          "imageName":"tab_chat",
                          "selectedImageName":"tab_chat_selected"],
                         ["title":"我的课",
                          "imageName":"tab_product",
                          "selectedImageName":"tab_product_selected"],
                         ["title":"个人中心",
                          "imageName":"tab_mine",
                          "selectedImageName":"tab_mine_selected"]]
        
        var viewControllers: [UIViewController] = []
        
        for (i, item) in configArr.enumerated() {
            
            let vc = ENavigationController(rootViewController: vcArr[i])
            
            vc.tabBarItem = UITabBarItem(title: item["title"], image: UIImage(named: item["imageName"]!)!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: item["selectedImageName"]!)!.withRenderingMode(.alwaysOriginal))
            
            vc.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.detailColor,.font:UIFont.systemFont(ofSize: 10)], for: .normal)
            vc.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.themeColor,.font:UIFont.systemFont(ofSize: 10)], for: .selected)
            viewControllers.append(vc)
        }
        
        self.viewControllers = viewControllers
    }
}
