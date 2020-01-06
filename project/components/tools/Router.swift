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
    func bridgeWith<T>(_ anyRoute:T) {
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
    
    private func bridgeWithRouteModel(_ routeModel:RouteModel) {
        
        if routeModel.extra.url.contains("itunes.apple.com") {
            UIApplication.shared.openURL(URL(string: routeModel.extra.url)!)
            return
        }
        
        switch routeModel.flag {
//        case "h5":
//            self.bridgerH5(routeModel.extra, .h5)
        case "login":
            self.presentLoginVC()
//        case "user_update":
//            //重新获取用户信息
//            UserHelper.instance.getUserInfo(false, success: {}) {}
//        case "app_update":
//            //重新获取app 版本信息
//            self.checkUpdate()

        case "home":
            self.getCurrentNav().popToRootViewController(animated: false)
            self.getTabbar().selectedIndex = 0
        case "left":
            self.getCurrentNav().popToRootViewController(animated: false)
            self.getTabbar().selectedIndex = 1
        case "right":
            self.getCurrentNav().popToRootViewController(animated: false)
            self.getTabbar().selectedIndex = 2
        case "mine":
            self.getCurrentNav().popToRootViewController(animated: false)
            self.getTabbar().selectedIndex = 3
            
        case "message":
            //            let message = MessageListViewController(nibName: "MessageListViewController", bundle: nil)
            //            Router.instance.getRootVC().pushViewController(message, animated: true)
            ToastTool.toast("功能开发中，敬请期待")
        case "share":
            print("分享功能开发中")
            
        case "tel":
            print("打电话")
//            UIApplication.shared.openURL(URL.init(string: "tel://\(routeModel.extra.number)")!)
        case "scan":
            self.getCurrentNav().pushViewController(ScannningVC(), animated: true)
            
        default:
            print("######没有\(routeModel.flag)这个页面######")
        }
    }
    
    func presentLoginVC() {
        let u = EBaseController(nibName: "EAgentLoginController", bundle: nil)
        let v = ENavigationController.init(rootViewController: u)
        self.getTabbar().present(v, animated: true, completion: nil)
    }
    
}


extension Router {
    
    //创建单利
    class var instance : Router {
        struct Static {
            static let instance = Router()
        }
        return Static.instance
    }
    
    func getTabbar() -> ETabBarController {
        guard let tabbar = mainWindow.rootViewController else {
            ELog("找不到根控制器")
            return ETabBarController()
        }
        return tabbar as! ETabBarController
    }
    
    func getCurrentNav() -> ENavigationController {
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
