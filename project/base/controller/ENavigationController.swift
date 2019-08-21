//
//  ENavigationController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

class ENavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
        
    }
    //重写父类push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
