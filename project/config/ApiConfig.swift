//
//  ApiConfig.swift
//  appwork
//
//  Created by lintong on 2019/5/6.
//  Copyright © 2019 EBIZHZ1. All rights reserved.
//

import UIKit

class ApiConfig {
    
    static let environmentStr = "DEV"

    // 接口路径
    static let apiPathDict: Dictionary<String, String> = {
        let url = Bundle.main.path(forResource: "ApiPath", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: url ?? " ")
        return dict as! Dictionary<String, String>
    }()
    // PRD和UAT(仅本文件访问)
    fileprivate class var apiEnviromentDict: Dictionary<String, String> {
        get {
            let url = Bundle.main.path(forResource: environmentStr, ofType: "plist")
            let dict = NSDictionary(contentsOfFile: url ?? " ")
            return dict as! Dictionary<String, String>
        }
    }
    // 获取url路径
    class final func getUrl(_ name: String) -> String {
        guard let url = apiPathDict[name] else {
            return " "
        }
        return url
    }
    
    // 根据当前环境环境获取baseUrl
    class final var baseUrl: String {
        get {
            return apiEnviromentDict["baseAPI"]!
        }
    }
    // 根据当前环境环境获取configUrl
    class final var configUrl: String {
        get {
            return apiEnviromentDict["configAPI"]!
        }
    }
    // 根据当前环境环境获取restfulUrl
    class final var restfulUrl: String {
        get {
            return apiEnviromentDict["restfulAPI"]!
        }
    }
    
}
