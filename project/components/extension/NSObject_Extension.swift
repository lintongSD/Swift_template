//
//  NSObject_Extension.swift
//  project
//
//  Created by ebiz on 2020/1/10.
//  Copyright © 2020 lintong. All rights reserved.
//

import Foundation

extension NSObject {
    /**
     * 模型转字典
     */
    func modelToDict() -> [String: Any] {
        var count: UInt32 = 0
        
        guard let propertyList = class_copyPropertyList(self.classForCoder, &count) else {
            return [:]
        }
        
        var dict: [String: Any] = Dictionary(minimumCapacity: Int(count))
        
        for index in 0..<Int(count) {
            let property = propertyList[index]
            
            if let key = String.init(utf8String: property_getName(property)) {  // 获取key
                if let value = self.value(forKeyPath: key) {
                    
                    if value is String || value is NSNumber {
                        dict.updateValue(value, forKey: key)
                    } else if value is [Any] || value is [String: Any] {
                        dict.updateValue(analysisObject(value), forKey: key)
                    } else {
                        dict.updateValue((value as! NSObject).modelToDict(), forKey: key)
                    }
                }
            }
        }
        return dict
    }
    /**
     * 数组、字典解析
     */
    private func analysisObject(_ object: Any) -> Any {
        if object is [Any] {
            var objArrM = Array<Any>()
            let objArr = object as! Array<Any>
            
            for item in objArr {
                if item is String || item is NSNumber {
                    objArrM.append(item)
                } else if item is [Any] ||  item is [String: Any] {
                    objArrM.append(self.analysisObject(item))
                } else if item is EBaseModel {
                    let model = item as! EBaseModel
                    objArrM.append(model.modelToDict())
                } else {
                    return ""
                }
            }
            return objArrM
        } else if object is [String: Any] {
            var dict = [String:Any]()
            let objDict = object as! [String: Any]
            
            for (key, value) in objDict {
                if value is String || value is NSNumber {
                    dict.updateValue(value, forKey: key)
                } else if value is [Any] ||  value is [String: Any] {
                    dict.updateValue(self.analysisObject(value), forKey: key)
                } else if value is EBaseModel {
                    let model = value as! EBaseModel
                    dict.updateValue(model.modelToDict(), forKey: key)
                } else {
                    return ""
                }
            }
        } else if object is String {
            return object
        }
        return ""
    }
    
}
