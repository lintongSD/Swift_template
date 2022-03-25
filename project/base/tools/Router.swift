//
//  Router.swift
//  Nanyuan-Swift
//
//  Created by lintong on 2020/11/30.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

class Router {

    enum RouterJumpType {
        case push
        case present
    }
    
    /// 路由枚举
    enum RouterFlag: String, HandyJSONEnum {
        case home
        case left
        case right
        case mine
        case mid
        
        case login
        case free = "FreeController"
        case coursePackage = "CoursePackageController"
        
        case h5 = "WebController"
        case scan = "ScanController"
        case service = "ServiceController"
        
        case tel
        case share
        case system
        case privicy = "PrivacyController"
        case feedBack
        case aboutUs = "AboutUsController"
        case copyright = "CopyrightController"
        
        case custom
        case bridge
    }
    
    typealias RouterBlock = (Any) -> Void
    
    var routerBlock: RouterBlock?
    
    //MARK : 通用route 跳转
    class func router(_ anyRouter: RouterFlag, param: [String:Any]? = nil, jumpType: RouterJumpType = .push) {
        print("route跳转++++++\(anyRouter)+++++++")
        
        var dict: [String: Any] = ["extra":param ?? ""]
        dict.updateValue(anyRouter, forKey: "flag")
        
        guard let routerModel = RouterModel.deserialize(from: dict) else {
            HUDTool.error("路由解析失败")
            return
        }
        
        routerTo(routerModel, jumpType: jumpType)
    }
    
    private class func routerTo(_ routerModel: RouterModel, jumpType: RouterJumpType) {
        
        let childrenCount = tabbar.children.count
        let sb = UIStoryboard.init(name: "Mine", bundle: nil)
        
        switch routerModel.flag {
        case .login:
            presentLogin()
        case .home:
            tabbar.selectedIndex = 0
        case .left:
            tabbar.selectedIndex = 1
        case .mid:
            tabbar.selectedIndex = Int(ceil(Double(childrenCount)/2.0))
        case .right:
            tabbar.selectedIndex = childrenCount-2
        case .mine:
            tabbar.selectedIndex = childrenCount-1
        case .share:
            print("分享功能开发中")
        case .tel:
            guard let telModel = RouterTelModel.deserialize(from: routerModel.extra), let url = URL.init(string: "tel://\(telModel.number)") else {
                return
            }
            UIApplication.shared.openURL(url)
        case .system:
            let vc = sb.instantiateViewController(withIdentifier: "SystemSettingController")
            jumpTo(vc, jumpType: jumpType)
        case .feedBack:
            let vc = sb.instantiateViewController(withIdentifier: "FeedbackController")
            jumpTo(vc, jumpType: jumpType)
        case .custom:
            routerToCustom(routerModel.extra, jumpType: jumpType)
        default:
            let className = routerModel.flag?.rawValue ?? ""
            guard let targetVC = creatController(className) else {
                HUDTool.error(className + "不存在")
                return
            }
            targetVC.extra = routerModel.extra
            jumpTo(targetVC, jumpType: jumpType)
        }
    }
    
    /// 跳转到指定控制器
    //    ["flag":"custom",
    //    "extra":["className":"vc",
    //            "extra":["str":Any]]]
    private class func routerToCustom(_ extra: [String: Any], jumpType: RouterJumpType) {
        guard let extraModel = RouterExtraModel.deserialize(from: extra) else {
            HUDTool.error("路由解析失败")
            return
        }
        
        guard let targetVC = creatController(extraModel.className) else {
            HUDTool.error(extraModel.className + "不存在")
            return
        }
        
        targetVC.extra = extraModel.extra
        jumpTo(targetVC, jumpType: jumpType)
    }
    
    // 根据类名创建控制器
    private class func creatController(_ vcName: String) -> EController? {
        guard let targetClass = classFrom(vcName), let targetType = targetClass as? EController.Type else{
            print("没有获取对应控制器的类型")
            return nil
        }
        return targetType.init()
    }
    
    // 跳转控制器
    private class func jumpTo(_ vc: UIViewController, jumpType: RouterJumpType) {
        switch jumpType {
        case .present:
            currentNav.present(vc, animated: true, completion: nil)
        case .push:
            currentNav.pushViewController(vc, animated: true)
        }
    }
    
    class func presentLogin() {
        let storyboard = UIStoryboard.init(name: "Mine", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginController")
        let nav = ENavigationController.init(rootViewController: vc)
        mainWindow.rootViewController = nav
    }
    
    class func presentTabbar() {
        mainWindow.rootViewController = ETabBarController()
    }
}

extension Router {
    // MARK: 字符串转换成类名
    private class func classFrom(_ className: String) -> AnyClass? {
        if className.isEmpty {
            return nil
        }
        /// 获取命名空间
        guard let namespace = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String else {
            return nil
        }
        /// 根据命名空间传来的字符串先转换成anyClass
        ELog(namespace + "." + className)
        guard let cls = NSClassFromString(namespace + "." + className) else {
            return nil
        }
        return cls
    }

}

// MARK: 控制器相关
extension Router {
    private class var tabbar: ETabBarController {
        guard let tabbar = mainWindow.rootViewController else {
            ELog("找不到根控制器")
            return ETabBarController()
        }
        return tabbar as! ETabBarController
    }
    
    private class var currentNav: ENavigationController {
        guard let nav = tabbar.selectedViewController else {
            ELog("找不到根控制器")
            return ENavigationController()
        }
        return nav as! ENavigationController
    }
}
