//
//  RouterModel.swift
//  project
//
//  Created by lintong on 2021/9/15.
//  Copyright © 2021 lintong. All rights reserved.
//

import UIKit

struct RouterModel: HandyJSON {
    var flag: Router.RouterFlag?
    var extra = [String: Any]()
}

// 跳转自定义控制器的Model
struct RouterExtraModel: HandyJSON {
    // 类名
    var className = ""
    var extra: [String: Any]?
}

// 打电话
struct RouterTelModel: HandyJSON {
    // 类名
    var number = ""
}
