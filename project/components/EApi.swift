//
//  EApi.swift
//  project
//
//  Created by EBIZM2 on 2019/8/21.
//  Copyright © 2019 EBIZM2. All rights reserved.
//

import UIKit

class EApi {
    
    class var instance : EApi {
        struct Static {
            static let instance = EApi()
        }
        return Static.instance
    }
    
    func getApiByName( _ name: String) -> String {
        if name.starts(with: "http://") || name.starts(with: "https://") {
            return name
        }
        return ApiConfig.instance.getUrl(name)
    }
    
    func getConfigApiByName(_ name: String) -> String {
        if name.starts(with: "http://") || name.starts(with: "https://") {
            return name
        }
        return ApiConfig.instance.configUrl + ApiConfig.instance.getUrl(name)
    }
    
    func getBaseApiByName(_ name: String) -> String {
        if name.starts(with: "http://") || name.starts(with: "https://") {
            return name
        }
        return ApiConfig.instance.baseUrl + ApiConfig.instance.getUrl(name)
    }
    
    
    
}
