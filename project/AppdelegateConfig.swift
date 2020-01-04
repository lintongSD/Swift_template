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
//        showGuideView()
        mainWindow.addSubview(ADView())
    }
    
    class func showGuideView() {
        // 按需求显示引导图(每次更新版本时显示)
        if Storage.oldVersion != appVersion {
            Storage.oldVersion = appVersion
            mainWindow.addSubview(GuideView())
        } else {
            //启动加载信息
            mainWindow.addSubview(ADView())
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


