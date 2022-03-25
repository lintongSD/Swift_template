//
//  EModel.swift
//  project
//
//  Created by lintong on 2018/10/17.
//  Copyright © 2018年 lintong. All rights reserved.
//

import UIKit
@_exported import HandyJSON
@_exported import SwiftyJSON

extension Array where Element: HandyJSON {
    
    public static func produceModels(_ models: [Any]?) -> [Element] {
        
        guard let modelArr = [Element].deserialize(from: models) else { return [] }
        
        return modelArr.filter { $0 != nil } as! [Element]
    }
    
    // 通过字符串创建模型数组
    public static func produceModels(_ modelString: String?) -> [Element] {
        
        guard let modelArr = [Element].deserialize(from: modelString) else { return [] }
        
        return modelArr.filter { $0 != nil } as! [Element]
    }
    
}
