//
//  BaseModel.swift
//  project
//
//  Created by EBIZHZ1 on 2018/10/17.
//  Copyright © 2018年 EBIZHZ1. All rights reserved.
//

import UIKit
import SwiftyJSON

@objcMembers
class EBaseModel: NSObject {

    init(_ dictionary: Dictionary<String, Any>) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value is NSNumber {
            var replaceString = String(describing: value)
            replaceString = replaceString.replacingOccurrences(of: "Optional", with: "")
            replaceString = replaceString.replacingOccurrences(of: "(", with: "")
            replaceString = replaceString.replacingOccurrences(of: ")", with: "")
            super.setValue(replaceString, forKey: key)
        } else if value is String {
            super.setValue(value, forKey: key)
        } else if value is Dictionary<String, Any> {
            super.setValue((value as! NSDictionary).toString, forKey: key)
        } else {
            super.setValue("", forKey: key)
        }
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        print("没有找到的值 : \(key)")
        return ""
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    required override init() {
        super.init()
    }
}


extension NSDictionary {
    //字典转字符串
    var toString: String {
        var result:String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            if let JSONString = String(data: jsonData, encoding: .utf8) {
                result = JSONString
            }
        } catch {
            result = ""
        }
        return result
    }
}
