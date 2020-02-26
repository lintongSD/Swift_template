//
//  NotificationTool.swift
//  project
//
//  Created by lintong on 2018/10/24.
//  Copyright © 2018年 lintong. All rights reserved.
//

import Foundation

enum NotificationKey: String {
    case loginSuccess = "loginSuccess"
    case logout = "logout"
    
    case tabReload = "tabReload"
}

class NotificationTool {
    class func post(_ name: NotificationKey) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: name.rawValue), object: nil))
    }
    
    class func postWithParam(_ name: NotificationKey, _ userInfo:NSDictionary)  {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: name.rawValue), object: nil, userInfo: userInfo as? [AnyHashable : Any]))
    }
    
    class func observer(_ observer: Any, _ selector: Selector, _ name: NotificationKey){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
    }
    
    class func remove(_ observer: NSObject, for notificationKey: NotificationKey) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: notificationKey.rawValue), object: nil)
    }
    
}
