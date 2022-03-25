//
//  EAPPLoadingModel.swift
//  project
//
//  Created by lintong on 2020/1/3.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

struct AppLoadingModel: HandyJSON {
    var flash = AppLoadingDetailModel()
    var iupdate = AppLoadingDetailModel()
}

struct AppLoadingDetailModel: HandyJSON {
    
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
