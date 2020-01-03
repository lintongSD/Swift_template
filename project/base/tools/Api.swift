//
//  EApi.swift
//  project
//
//  Created by lintong on 2019/8/21.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

class Api {
    
    class func getApiByName( _ name: String) -> String {
        if name.starts(with: "http://") || name.starts(with: "https://") {
            return name
        }
        return ApiConfig.getUrl(name)
    }
    
    class func getConfigApiByName(_ name: String) -> String {
        if name.starts(with: "http://") || name.starts(with: "https://") {
            return name
        }
        return ApiConfig.configUrl + ApiConfig.getUrl(name)
    }
    
    class func getBaseApiByName(_ name: String) -> String {
        if name.starts(with: "http://") || name.starts(with: "https://") {
            return name
        }
        return ApiConfig.baseUrl + ApiConfig.getUrl(name)
    }
    
    
    
}
