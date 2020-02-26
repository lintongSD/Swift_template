//
//  Storage.swift
//  project
//
//  Created by lintong on 2018/10/18.
//  Copyright © 2018年 lintong. All rights reserved.
//
//用户信息存储类

import UIKit
import WebKit

class StorageKey: NSObject {
    static let token = "token"
    // 判断是否需要提示更新版本
    static let update_version = "updateVersion"
    // 发布新版本会有轮播图
    static let old_version = "old_version"
    // 主题色
    static let theme_color = "theme_color"
    // tabbar颜色配置
    static let tint_color = "tint_color"
    static let barTint_color = "barTint_color"
}

class Storage {
    
    //清空存储的用户信息
    class func clearUserInfo() {
        token = ""
        UserStorage.userModel = UserModel([:])
        removeWKWebViewCookies()
    }
    
    //=================用户Token=================
    class var token: String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageKey.token)
            UserDefaults.standard.synchronize()
        }
        get {
            let token = UserDefaults.standard.object(forKey: StorageKey.token)
            return token == nil ? "" : token as! String
        }
    }
    
    class func removeWKWebViewCookies() {
        //iOS9.0以上使用的方法
        if #available(iOS 9.0, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: { (records) in
                for record in records{
                    //清除本站的cookie
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                    })
                }
            })
        } else {
            //ios8.0以上使用的方法
            let libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let cookiesPath = libraryPath! + "/Cookies"
            do {
                try FileManager.default.removeItem(atPath: cookiesPath)
            } catch {
            }
            for cookie in (HTTPCookieStorage.shared.cookies)!{
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
}
// MARK: app相关存储
extension Storage {
    // 版本更新
    class var updateVersion: String {
        get {
            let version = UserDefaults.standard.object(forKey: StorageKey.update_version)
            return version == nil ? "" : version as! String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageKey.update_version)
            UserDefaults.standard.synchronize()
        }
    }
    class var oldVersion: String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageKey.old_version)
            UserDefaults.standard.synchronize()
        }
        get {
            let version = UserDefaults.standard.object(forKey: StorageKey.old_version)
            return version == nil ? "" : version as! String
        }
    }
    // app颜色相关
    class var themeColor: String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageKey.theme_color)
            UserDefaults.standard.synchronize()
        }
        get {
            let color = UserDefaults.standard.object(forKey: StorageKey.theme_color)
            return color == nil ? "FB866D" : color as! String
        }
    }
    
    class var tabbarConfig: [String: Any] {
        get {
            guard let dict = UserDefaults.standard.object(forKey: "tabbarModel") else {
                let dict: [String: Any] = ["tabbar":["home":["label":"首页",
                                                             "flag":"home",
                                                             "url":"https://baidu.com"],
                                                     "mid":["label":"产品",
                                                              "flag":"product"],
                                                     "mine":["label":"我的",
                                                             "flag":"mine"]],
                                           "theme":["unselectedColor":"666666",
                                                    "selectedColor":"6699ff",
                                                    "navigation":Storage.themeColor],
                                           "selectedKey":"home",
                                           "DEV_url":"",
                                           "PRD_url":"",]
                return dict
            }
            return dict as! [String : Any]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "tabbarModel")
        }
    }
}
