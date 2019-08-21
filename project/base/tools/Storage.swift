//
//  EStorage.swift
//  project
//
//  Created by EBIZHZ1 on 2018/10/18.
//  Copyright © 2018年 EBIZHZ1. All rights reserved.
//
//用户信息存储类

import UIKit
import WebKit

class StorageKey:NSObject {
    static let token = "token"
    // 登录标识
    static let login = "is_login"
    // 判断是否需要提示更新版本
    static let updateVersion = "updateVersion"
    // 发布新版本会有轮播图
    static let old_version = "old_version"
}

class Storage: NSObject {

    private override init() {}
    
    //创建单利
    class var instance : Storage {
        struct Static {
            static let instance = Storage()
        }
//        ENotification.instance.observer(Static.instance, #selector(clearUserInfo),  ENotificationKey.LOGOUT)
        return Static.instance
    }
    
    //清空存储的用户信息
    @objc func clearUserInfo() {
        self.token = ""
        Storage.instance.isLogin = false
//        JPUSHService.deleteAlias(nil, seq: 0)
//        UserHelper.instance.userInfoModel = UserInfoModel([:])
        removeWKWebViewCookies()
    }
    
    //=================用户Token=================
    var token: String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageKey.token)
            UserDefaults.standard.synchronize()
        }
        get {
            let token = UserDefaults.standard.object(forKey: StorageKey.token)
            return token == nil ? "" : token as! String
        }
    }
    //=================是否登录=================
    var isLogin: Bool {
        set {
            UserDefaults.standard.setValue(newValue ,forKey: StorageKey.login)
            UserDefaults.standard.synchronize()
        }
        get {
            let version = UserDefaults.standard.object(forKey: StorageKey.login)
            return version == nil ? false : version as! Bool
        }
    }
    //=================需要更新版本=================
    var updateVersion: String {
        get {
            let version = UserDefaults.standard.object(forKey: StorageKey.updateVersion)
            return version == nil ? "" : version as! String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageKey.updateVersion)
            UserDefaults.standard.synchronize()
        }
    }
    //=================旧版本=================
    var oldVersion: String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageKey.old_version)
            UserDefaults.standard.synchronize()
        }
        get {
            let version = UserDefaults.standard.object(forKey: StorageKey.old_version)
            return version == nil ? "" : version as! String
        }
    }
    
    func removeWKWebViewCookies(){
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
