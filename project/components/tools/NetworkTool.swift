//
//  ENetworkTool.swift
//  TestAlamofire
//
//  Created by lintong on 2019/12/13.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class NetworkTool {
    
    /**
     * 正常请求
     */
    class func request(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        requestWithHeader(url: url, method: method, parameters: parameters, headers: nil, success: success, failure: failure)
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
     * 设置请求头
     */
    class func requestWithHeader(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, headers: HTTPHeaders?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        var header = headers
        if header == nil {
            header = [:]
        }
        header?.updateValue(Storage.token, forKey: "token")
        requestURLEncoding(url: url, method: method, parameters: parameters, headers: header, success: success, failure: failure)
    }
    
    /**
     * JSON请求
     */
    class func requestJSON(url: String, method: HTTPMethod, parameters: Dictionary<String, Any>?, success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        requestJSONEncoding(url: url, method: method, parameters: parameters, headers: nil, success: success, failure: failure)
    }
    /**
     * 图片上传
     */
    class func uploadImage(url: String, parameters: Dictionary<String, Any>?, images: [UIImage], success: @escaping (JSON) -> Void, failure: @escaping (Error?) -> Void) {
        guard let uploadUrl = URL(string: url) else {
            ELog("图片上传路径有误" + url)
            return
        }
        let manager = Alamofire.SessionManager.default
        let headers = ["token":Storage.token]
        let request = try! URLRequest(url: uploadUrl, method: .post, headers: headers)
        
        manager.upload(multipartFormData: { (formData) in
            for (index, image) in images.enumerated() {
                let data = image.jpegData(compressionQuality: 1)
                if data?.count ?? 0 > 0 {
                    // 前端不对图片名进行处理
                    let name = "image\(index)"
                    formData.append(data!, withName: name, fileName: "\(name).jpg", mimeType: "image/jpg")
                }
            }
        }, with: request) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    guard let value = response.result.value else {
                        if response.error?.localizedDescription == "已取消" {
                            return
                        }
                        failure(response.error)
                        return
                    }
                    if response.result.isSuccess {
                        success(JSON(value))
                    } else {
                        failure(response.error)
                    }
                })
            case .failure(let error):
                failure(error)
            }
        }
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
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (responce) in
            ELog("\n" + url + " \(JSON(responce.result.value as Any))")
            switch responce.result {
            case .success:
                success(JSON(responce.result.value as Any))
            case .failure:
                failure(responce.result.error)
            }
        }
    }
}

//struct NetworkError: Error {
//    var description = ""
//    var localizedDescription: String {
//        return description
//    }
//
//    init(_ desc: String) {
//        self.description = desc
//    }
//}

extension NetworkTool {
    /**
     * 配置https证书
     */
    class func configSSL() {
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = {session, challenge in
            //认证服务器证书
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                print("服务端证书认证！")
                let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!
                let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
                let remoteCertificateData = CFBridgingRetain(SecCertificateCopyData(certificate))!

                //app端证书
                let cerPath = Bundle.main.path(forResource: "app", ofType: "cer")!
                let cerUrl = URL(fileURLWithPath:cerPath)
                let localCertificateData = try! Data(contentsOf: cerUrl)
                
                if (remoteCertificateData.isEqual(localCertificateData) == true) {
                    let credential = URLCredential(trust: serverTrust)
                    challenge.sender?.use(credential, for: challenge)
                    return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust: challenge.protectionSpace.serverTrust!))
                } else {
                    return (.cancelAuthenticationChallenge, nil)
                }
            } else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate {
                print("客户端证书认证！")
                let identityAndTrust:IdentityAndTrust = self.extractIdentity()
                let urlCredential:URLCredential = URLCredential(identity: identityAndTrust.identityRef,certificates: identityAndTrust.certArray as? [AnyObject],persistence: URLCredential.Persistence.forSession);
                return (.useCredential, urlCredential)
            } else {
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    
    //获取客户端证书相关信息
    private class func extractIdentity() -> IdentityAndTrust {
        var identityAndTrust:IdentityAndTrust!
        var securityError:OSStatus = errSecSuccess

        //服务端证书
        let path: String = Bundle.main.path(forResource: "server", ofType: "p12")!
        let PKCS12Data = NSData(contentsOfFile:path)!
        let key : NSString = kSecImportExportPassphrase as NSString
        let options : NSDictionary = [key : "111111"] //客户端证书密码
        //create variable for holding security information
        //var privateKeyRef: SecKeyRef? = nil
        
        var items : CFArray?
        
        securityError = SecPKCS12Import(PKCS12Data, options, &items)
        
        if securityError == errSecSuccess {
            let certItemsArray = items as! Array<Any>
            let dict = certItemsArray.first as AnyObject?
            if let certEntry = dict as? Dictionary<String, AnyObject> {
                // grab the identity
                let identityPointer = certEntry["identity"]
                let secIdentityRef = identityPointer as! SecIdentity
                // grab the trust
                let trustPointer = certEntry["trust"]
                let trustRef = trustPointer as! SecTrust
                // grab the cert
                let chainPointer = certEntry["chain"]
                identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,
                                                    trust: trustRef, certArray:  chainPointer!)
            }
        }
        return identityAndTrust
    }
    //定义一个结构体，存储认证相关信息
    struct IdentityAndTrust {
        var identityRef:SecIdentity
        var trust:SecTrust
        var certArray:AnyObject
    }
}
