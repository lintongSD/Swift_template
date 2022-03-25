//
//  AppdelegateConfig.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit
import Alamofire

class AppdelegateConfig {
    static let networkListener = NetworkReachabilityManager()
    
    class func config() {
        startListeningNetwork()
        setWebviewUserAgent()
        checkAppConfig()
        tabbarConfig()
    }
    
    // tabbar配置
    class func tabbarConfig() {
        NetworkTool.requestJSON(url: ApiManager.getBaseApiByName("tabConfigAPI"), method: .get, parameters: nil, success: { (json) in
            if json["code"].stringValue == "0" && json["content"].dictionary != nil {
                Storage.tabbarConfig = json["content"]["data"].dictionaryObject ?? [:]
                NotificationTool.post(NotificationKey.tabReload)
            }
        }) { (error) in
        }
    }
    
    // 检查app配置
    class func checkAppConfig() {
        // 按需求显示引导图(每次更新版本时显示)
        if Storage.oldVersion != appVersion {
            Storage.oldVersion = appVersion
            mainWindow.addSubview(GuideView())
            NetworkTool.requestJSON(url: ApiManager.getBaseApiByName("appLoadingAPI"), method: .get, parameters: nil, success: { (json) in
                if let dict = json["content"]["data"].dictionaryObject {
                    let appLoadingModel = AppLoadingModel.deserialize(from:dict) ?? AppLoadingModel()
                    //版本检查
                    UpDateView.checkVersion(appLoadingModel)
                }
            }) { (error) in
            }
        } else {
            // 启动加载信息
            mainWindow.addSubview(ADView())
        }
    }
    
    class func setWebviewUserAgent() {
        let webView = WKWebView(frame: CGRect.zero)
        webView.evaluateJavaScript("navigator.userAgent") { (obj, error) in
            let oldAgent = obj as! String
            userAgent = oldAgent.appending(" GHAPP_iOS_V2_1.0.4")
            UserDefaults.standard.register(defaults: ["UserAgent" : userAgent])
            UserDefaults.standard.synchronize()
            if #available(iOS 9.0, *) {
                webView.customUserAgent = userAgent
            }
        }
    }
    
    class func startListeningNetwork() -> Void {
        networkListener?.listener = { status in
            if networkListener?.isReachable ?? false {
                switch status{
                case .notReachable:
                    ELog("网络不可用")
                case .unknown:
                    ELog("不知名的网络")
                case .reachable(.ethernetOrWiFi):
                    ELog("通过WiFi链接")
                case .reachable(.wwan):
                    ELog("通过移动网络链接")
                }
            } else {
                ELog("网络不可用")
            }
        }
        networkListener?.startListening()
    }
}
var userAgent = ""
