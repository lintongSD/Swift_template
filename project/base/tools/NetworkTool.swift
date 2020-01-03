//
//  ENetworkTool.swift
//  TestAlamofire
//
//  Created by ebiz on 2019/12/13.
//  Copyright © 2019 ebiz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class NetworkTool {
    
    /**
     * 正常请求
     */
    class func request(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        requestURLEncoding(url: url, method: method, parameters: parameters, headers: nil, success: success, failure: failure)
    }
    /**
     * JSON请求
     */
    class func requestJSON(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        requestJSONEncoding(url: url, method: method, parameters: parameters, headers: nil, success: success, failure: failure)
    }
    /**
     * 加签
     */
    class func requestSign(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        requestSignHeader(url: url, method: method, parameters: parameters, headers: nil, success: success, failure: failure)
    }
    /**
     * 加签设置请求头
     */
    class func requestSignHeader(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, headers: HTTPHeaders?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        let param: NSMutableDictionary
        if parameters == nil {
            param = [:]
        } else {
            param = NSMutableDictionary(dictionary: parameters!)
        }
        let dict = JSON(param).dictionaryObject
        requestURLEncoding(url: url, method: method, parameters: dict, headers: headers, success: success, failure: failure)
    }
    
    /**
     * 已设置token请求头
     * 拼接请求头
     */
    class func requestWithHeader(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, headers: HTTPHeaders?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        var header = headers
        if header == nil {
            header = [:]
        }
        header?.updateValue("token", forKey: "token")
        requestURLEncoding(url: url, method: method, parameters: parameters, headers: header, success: success, failure: failure)
    }
    
    
    //MARK:  私有方法禁止修改
    /**
     *  请求方式URLEncoding
     */
    private class func requestURLEncoding(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, headers: HTTPHeaders?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        request(url: url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers, success: success, failure: failure)
    }
    /**
     *  请求方式JSONEncoding
     */
    private class func requestJSONEncoding(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, headers: HTTPHeaders?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        request(url: url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers, success: success, failure: failure)
    }
    /*
     * 设置网络请求的编码方式
     */
    private class func request(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, encoding: ParameterEncoding, headers: HTTPHeaders?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (responce) in
            print(url + "\(JSON(responce.result.value as Any))")
            switch responce.result {
            case .success:
                success(JSON(responce.result.value as Any))
            case .failure:
                failure(responce.result.error)
            }
        }
    }
    
    
}
