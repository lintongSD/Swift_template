//
//  Router.swift
//  project
//
//  Created by ebiz on 2020/1/6.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit
import SwiftyJSON

class Router: NSObject {
    
    internal override init() {}
    
    //MARK : 通用route 跳转 支持string类型或者model的跳转
    class func bridgeWith<T>(_ anyRoute:T) {
        print("route跳转+++++++++++++")
        print(anyRoute)
        if let route = anyRoute as? String {
            let jsonValue = JSON(parseJSON: route)
            let dic = jsonValue.dictionaryObject ?? [:]
            let model = RouteModel(dic)
            self.bridgeWithRouteModel(model)
        } else if let route = anyRoute as? RouteModel {
            self.bridgeWithRouteModel(route)
        }
        
    }
    
    private class func bridgeWithRouteModel(_ routeModel:RouteModel) {
        
        switch routeModel.flag {
//        case "h5":
//            self.bridgerH5(routeModel.extra, .h5)
        case "login":
            self.presentLoginVC()
//        case "user_update":
//            //重新获取用户信息
//            UserHelper.instance.getUserInfo(false, success: {}) {}

        case "home":
            currentNav.popToRootViewController(animated: false)
            tabbar.selectedIndex = 0
        case "left":
            currentNav.popToRootViewController(animated: false)
            tabbar.selectedIndex = 1
        case "right":
            currentNav.popToRootViewController(animated: false)
            tabbar.selectedIndex = 2
        case "mine":
            currentNav.popToRootViewController(animated: false)
            tabbar.selectedIndex = 3
            
        case "message":
            ToastTool.toast("功能开发中，敬请期待")
        case "share":
            print("分享功能开发中")
            
        case "tel":
            print("打电话")
//            UIApplication.shared.openURL(URL.init(string: "tel://\(routeModel.extra.number)")!)
        case "scan":
            currentNav.pushViewController(ScannningVC(), animated: true)
            
        default:
            print("######没有\(routeModel.flag)这个页面######")
        }
    }
    
    class func presentLoginVC() {
        let u = LoginController(nibName: "LoginController", bundle: nil)
        let v = ENavigationController.init(rootViewController: u)
        tabbar.present(v, animated: true, completion: nil)
    }
    
}


extension Router {
        
    class var tabbar: ETabBarController {
        guard let tabbar = mainWindow.rootViewController else {
            ELog("找不到根控制器")
            return ETabBarController()
        }
        return tabbar as! ETabBarController
    }
    
    class var currentNav: ENavigationController {
        guard let tabVC = mainWindow.rootViewController else {
            ELog("找不到根控制器")
            return ENavigationController()
        }
        guard let nav = (tabVC as! ETabBarController).selectedViewController else {
            ELog("找不到根控制器")
            return ENavigationController()
        }
        return nav as! ENavigationController
    }
    
    
    
}
