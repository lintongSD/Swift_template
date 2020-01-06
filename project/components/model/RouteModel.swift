//
//  RouteModel.swift
//  project
//
//  Created by ebiz on 2020/1/6.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

class RouteModel: EBaseModel {
    // 跳转页面
    var flag = ""
    // 传递参数
    var extra = RouteExtraModel([:])
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "extra" && value is Dictionary<String, Any> {
            self.extra = RouteExtraModel(value as! Dictionary<String, Any>)
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class RouteExtraModel: EBaseModel {
    var url = ""
    var title = ""
    var login = ""
    var idAuth = ""
}
