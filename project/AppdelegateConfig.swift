//
//  AppdelegateConfig.swift
//  project
//
//  Created by EBIZM2 on 2019/8/20.
//  Copyright © 2019 EBIZM2. All rights reserved.
//

import UIKit

class AppdelegateConfig: NSObject {

    private override init() {}
    
    static func config() {
        showGuideView()
    }
    
    static func showGuideView() {
        // 按需求显示引导图
        if Storage.instance.oldVersion != appVersion {
            Storage.instance.oldVersion = appVersion
            mainWindow.addSubview(GuideView())
        } else {
            //启动加载信息
            mainWindow.addSubview(ADView())
        }
    }
    
}
