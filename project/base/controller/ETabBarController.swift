//
//  ETabBarController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit
import SwiftyJSON

class ETabBarController: UITabBarController {
    
    private var baseUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationTool.observer(self, #selector(addChildVC), NotificationKey.tabReload)
        
        self.tabBar.isTranslucent = false
        addChildVC()
    }
    
    @objc func addChildVC() {
        let dict = Storage.tabbarConfig
        var controllers = [UIViewController]()
        baseUrl = JSON(dict)["\(ApiConfig.environmentStr)" + "_url"].stringValue
        
        // 添加控制
        for key in ["home", "left", "mid", "right", "mine"] {
            if let vc = getVC(dict: JSON(dict)["tabbar"][key].dictionaryValue) {
                configTabBarItem(vc: vc, info: JSON(dict)["tabbar"][key])
                controllers.append(vc)
                if key == "mid" && JSON(dict)["tabbar"][key]["label"].stringValue.isEmpty {
                    vc.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0)
                }
            }
        }
        self.viewControllers = controllers
        
        switch JSON(dict)["selectedKey"] {
        case "home":
            self.selectedIndex = 0
        case "left":
            self.selectedIndex = 1
        case "mid":
            self.selectedIndex = Int(ceil(Double(controllers.count)/2.0))
        case "right":
            self.selectedIndex = controllers.count-2
        case "mine":
            self.selectedIndex = controllers.count-1
        default:
            self.selectedIndex = 0
        }
    }
    
    func getVC(dict: [String: JSON]) -> UIViewController? {
        
        var dictInfo = JSON(dict).dictionaryObject ?? [:]
        var url = dict["url"]?.stringValue ?? ""
        if !url.hasPrefix("http") {
            url = baseUrl + url
            dictInfo.updateValue(JSON(url), forKey: "url")
        }
        
        switch dict["flag"]?.stringValue {
        case "home":
            let vc = HomeController()
            let nav = ENavigationController(rootViewController: vc)
            vc.requestUrl = url
            return nav
        case "product":
            let vc = ProductController()
            let nav = ENavigationController(rootViewController: vc)
            vc.model = RouteExtraModel(dictInfo)
            return nav
        case "service":
            let vc = ProductController()
            let nav = ENavigationController(rootViewController: vc)
            vc.model = RouteExtraModel(dictInfo)
            return nav
        case "mine":
            let vc = MineController()
            let nav = ENavigationController(rootViewController: vc)
            vc.requestUrl = url
            return nav
        case "chat":
            let vc = WebController()
            let nav = ENavigationController(rootViewController: vc)
            vc.model = RouteExtraModel(dictInfo)
            return nav
        default:
            ELog("没有对应的flag" + (dict["flag"]?.stringValue ?? ""))
        }
        return nil
    }
    
    func configTabBarItem(vc: UIViewController, info: JSON) {
        
        let defaultImage = UIImage(named: "tab_" + "\(info["flag"].stringValue)")
        
        let defaultSelectedImage = UIImage(named: "tab_" + "\(info["flag"].stringValue)" + "_selected")
        
        let dict = Storage.tabbarConfig
        vc.tabBarItem = UITabBarItem(title: info["label"].stringValue, image: defaultImage!.withRenderingMode(.alwaysOriginal), selectedImage: defaultSelectedImage!.withRenderingMode(.alwaysOriginal))
        vc.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.colorWithHexString(color: JSON(dict)["theme"]["unselectedColor"].stringValue),.font:UIFont.systemFont(ofSize: 10)], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.colorWithHexString(color: JSON(dict)["theme"]["selectedColor"].stringValue),.font:UIFont.systemFont(ofSize: 10)], for: .selected)
        
        if let url = URL(string: info["unselected"].stringValue) {
            SDWebImageManager.shared.loadImage(with: url, options: .highPriority, progress: nil) { (image, data, error, cacheType, isSucceed, url) in
            }
            let cacheKey = SDWebImageManager.shared.cacheKey(for: url)
            let image = SDImageCache.shared.imageFromDiskCache(forKey: cacheKey)
            
            let selectedCacheKey = SDWebImageManager.shared.cacheKey(for: URL(string: info["selected"].stringValue)!)
            let selectedImage = SDImageCache.shared.imageFromDiskCache(forKey: selectedCacheKey) ?? defaultSelectedImage
            
            vc.tabBarItem = UITabBarItem(title: info["label"].stringValue, image: image!.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage!.withRenderingMode(.alwaysOriginal))
        }
        
        if let url = URL(string: info["selected"].stringValue) {
            SDWebImageManager.shared.loadImage(with: url, options: .highPriority, progress: nil) { (image, data, error, cacheType, isSucceed, url) in
            }
            let selectedCacheKey = SDWebImageManager.shared.cacheKey(for: url)
            let selectedImage = SDImageCache.shared.imageFromDiskCache(forKey: selectedCacheKey)
            
            let cacheKey = SDWebImageManager.shared.cacheKey(for: URL(string: info["unselected"].stringValue)!)
            let image = SDImageCache.shared.imageFromDiskCache(forKey: cacheKey) ?? defaultImage
            
            vc.tabBarItem = UITabBarItem(title: info["label"].stringValue, image: image!.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage!.withRenderingMode(.alwaysOriginal))
        }
        
    }
    
    
}
