//
//  ApiConfig.swift
//  appwork
//
//  Created by EBIZM2 on 2019/5/6.
//  Copyright © 2019 EBIZHZ1. All rights reserved.
//

import UIKit

class ApiConfig {
    
    class var instance : ApiConfig {
        struct Static {
            static let instance = ApiConfig()
        }
        return Static.instance
    }
    
#if DEBUG
    var environmentStr: String = "DEV"
#else
    var environmentStr: String = "PRD"
#endif
    // 接口路径
    let apiPathDict: Dictionary<String, String> = {
        let url = Bundle.main.path(forResource: "ApiPath", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: url ?? " ")
        return dict as! Dictionary<String, String>
    }()
    // PRD和UAT
    var apiEnviromentDict: Dictionary<String, String> {
        get {
            let url = Bundle.main.path(forResource: environmentStr, ofType: "plist")
            let dict = NSDictionary(contentsOfFile: url ?? " ")
            return dict as! Dictionary<String, String>
        }
    }
    // 获取固定url
    final func getUrl(_ name: String) -> String {
        guard let url = apiPathDict[name] else {
            return " "
        }
        return url
    }
    
    // 根据当前环境环境获取baseUrl
    final var baseUrl: String {
        get {
            return apiEnviromentDict["baseAPI"]!
        }
    }
    // 根据当前环境环境获取configUrl
    final var configUrl: String {
        get {
            return apiEnviromentDict["configAPI"]!
        }
    }
    // 根据当前环境环境获取restfulUrl
    final var restfulUrl: String {
        get {
            return apiEnviromentDict["restfulAPI"]!
        }
    }
    
}
