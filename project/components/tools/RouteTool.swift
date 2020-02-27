//
//  Router.swift
//  project
//
//  Created by lintong on 2020/1/6.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit
import SwiftyJSON

class RouteTool: NSObject {
    
    //MARK : 通用route 跳转 支持string类型或者model的跳转
    class func bridgeWith<T>(_ anyRoute: T) {
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
    
    private class func bridgeWithRouteModel(_ routeModel: RouteModel) {
        
        let childrenCount = tabbar.children.count
        
        switch routeModel.flag {
        case "h5":
            self.bridgeH5(routeModel)
        case "login":
            self.pushLoginVC()
        case "home":
            tabbar.selectedIndex = 0
        case "left":
            tabbar.selectedIndex = 1
        case "mid":
            tabbar.selectedIndex = Int(ceil(Double(childrenCount)/2.0))
        case "right":
            tabbar.selectedIndex = childrenCount-2
        case "mine":
            tabbar.selectedIndex = childrenCount-1
        case "message":
            ToastTool.toast("功能开发中，敬请期待")
        case "share":
            print("分享功能开发中")
            
        case "tel":
            print("打电话")
            UIApplication.shared.openURL(URL.init(string: "tel://\(routeModel.extra.number)")!)
        case "scan":
            currentNav.pushViewController(ScannningVC(), animated: true)
            
        default:
            print("######没有\(routeModel.flag)这个页面######")
        }
    }
    
    private class func bridgeH5(_ routeModel: RouteModel) {
        let webVC = WebController()
        webVC.model = routeModel.extra
        currentNav.pushViewController(webVC, animated: true)
    }
    
}


extension RouteTool {
    
    class var tabbar: ETabBarController {
        guard let tabbar = mainWindow.rootViewController else {
            ELog("找不到根控制器")
            return ETabBarController()
        }
        return tabbar as! ETabBarController
    }
    
    class var currentNav: ENavigationController {
        guard let nav = tabbar.selectedViewController else {
            ELog("找不到根控制器")
            return ENavigationController()
        }
        return nav as! ENavigationController
    }
    class func pushLoginVC() {
        let loginVC = LoginController(nibName: "LoginController", bundle: nil)
        currentNav.pushViewController(loginVC, animated: true)
    }
}
