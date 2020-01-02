//
//  Enoti.swift
//  project
//
//  Created by EBIZHZ0 on 2018/10/24.
//  Copyright © 2018年 EBIZHZ1. All rights reserved.
//

import Foundation

enum ENotificationKey: String {
    case loginSuccess = "loginSuccess"
    case logout = "logout"
}

class ENotification {
    class func post(_ name: ENotificationKey) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: name.rawValue), object: nil))
    }
    
    class func postWithParam(_ name: ENotificationKey, _ userInfo:NSDictionary)  {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: name.rawValue), object: nil, userInfo: userInfo as? [AnyHashable : Any]))
    }
    
    class func observer(_ observer: Any, _ selector: Selector, _ name: ENotificationKey){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
    }
    
    class func remove(_ observer: NSObject, for notificationKey: ENotificationKey) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: notificationKey.rawValue), object: nil)
    }
    
}
