//
//  EBaseWebView.swift
//  project
//
//  Created by ebiz on 2020/1/9.
//  Copyright © 2020 lintong. All rights reserved.
//

import WebKit

class EBaseWebView: WKWebView {
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        EBaseWebView.injectionToWeb(configuration.userContentController)
    }
    
    class func injectionToWeb(_ controller: WKUserContentController) {
        let jsArr = [
            "window.localStorage.setItem(\"token\",\"\(Storage.token)\");",
            //尽量不要设置cookie
            //加domain和apath 指定当前域名的路径
            //不设置domain 默认当前域名 = "path=/;"
            //不设置path 默认当前域名 和 截止到xx.html前的路径 = "path=/;" 和 "path=xxx/xx;"
            //ajax中的cookie获取的是"path=/;"
            "document.cookie = 'token=ddadaadad; domain=dat-m.lxebao.com; path=/;'"
            ]
        for jsStr in jsArr {
            let userScript = WKUserScript(source: jsStr, injectionTime: .atDocumentStart, forMainFrameOnly: false)
            controller.addUserScript(userScript)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("aaaaaaaaaaaa")
    }
}

