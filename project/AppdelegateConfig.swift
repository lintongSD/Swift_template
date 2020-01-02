//
//  AppdelegateConfig.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

class AppdelegateConfig: NSObject {

    private override init() {}
    
    static func config() {
//        showGuideView()
    }
    
    static func showGuideView() {
        // 按需求显示引导图(每次更新版本时显示)
        if Storage.oldVersion != appVersion {
            Storage.oldVersion = appVersion
            mainWindow.addSubview(GuideView())
        } else {
            //启动加载信息
            mainWindow.addSubview(ADView())
        }
    }
    
}
