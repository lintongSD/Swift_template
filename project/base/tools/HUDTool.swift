//
//  HUDTool.swift
//  project
//
//  Created by lintong on 2020/11/26.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit
import SVProgressHUD

class HUDTool {
    let showTime = 2
    
    // 网络错误
    // 数据有误
    // 成功弹框
    // 自定义
    enum NetworkTips {
        case networkError
        case dataError(_ text: String? = nil)
        case success(_ text: String)
        case customTip(_ text: String)
    }
    
    /// 一直显示
    class func loading(_ text: String? = nil) {
        SVProgressHUD.show(withStatus: text)
    }
    /// 默认显示0.5s
    class func show(_ text: String? = nil, _ timeInterval: TimeInterval = 0.5) {
        SVProgressHUD.show(withStatus: text)
        SVProgressHUD.dismiss(withDelay: timeInterval)
    }
    
    /// 显示进度
    class func progress(_ progress: Float, _ text: String? = nil, _ timeInterval: TimeInterval = 0.5) {
        SVProgressHUD.showProgress(progress, status: text)
        SVProgressHUD.dismiss(withDelay: timeInterval)
    }
    /// 显示成功
    class func success(_ text: String? = nil, _ dismissInterval: TimeInterval = 0.5) {
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: dismissInterval)
    }
    
    /// 显示错误信息, 默认0.5s
    class func error(_ text: String? = nil, _ dismissInterval: TimeInterval = 0.5) {
        SVProgressHUD.showError(withStatus: text)
        SVProgressHUD.dismiss(withDelay: dismissInterval)
    }
    
    /// 隐藏
    class func dismiss(_ timeInterval: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: timeInterval)
    }
    
    class func networkTip(_ tip: NetworkTips) {
        switch tip {
        case .networkError:
            error("网络异常, 请检查您的网络")
        case .dataError(let text):
            if let text = text {
                error(text)
            } else {
                error("数据有误, 请稍后再试")
            }
        case .success(let text):
            success(text)
            
        case .customTip(let text):
            show(text)
        }
    }
    
    class func showMessage(_ json: JSON) {
        error(json["message"].stringValue)
    }
    
}
