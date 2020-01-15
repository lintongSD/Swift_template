//
//  EAPPLoadingModel.swift
//  project
//
//  Created by lintong on 2020/1/3.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

class AppLoadingModel: EBaseModel {
    var flash = AppLoadingDetailModel([:])
    var update = AppLoadingDetailModel([:])
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "flash"  && value is Dictionary<String, Any> {
            self.flash = AppLoadingDetailModel(value as! Dictionary<String, Any>)
        } else if key == "update" && value is NSDictionary {
            self.update = AppLoadingDetailModel(value as! Dictionary<String, Any>)
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class AppLoadingDetailModel: EBaseModel {
    
    var img = ""
    var ximg = ""
    var mversion = ""
    var cversion = ""
    var vname = ""
    var content = ""
    var aurl = ""
    var prdUrl = "" //生产包的下载地址
    var route = ""
    
}
