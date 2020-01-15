//
//  EWebController.swift
//  project
//
//  Created by lintong on 2020/1/9.
//  Copyright © 2020 lintong. All rights reserved.
//

import WebKit

class EWebController: EBaseController {
    
    var model = RouteExtraModel([:])
    
    var webView = EBaseWebView()
    
    /**
     * webView只负责展示, bridge负责交互, 在mvc模型中相当于controller的角色, 所以不应该放在view里
     */
    var bridge: WebViewJavascriptBridge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = CGRect(x: 0, y: navigationHeight, width: screenWidth, height: screenHeight-navigationHeight)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        bridge = WebViewJavascriptBridge.init(forWebView: webView)
        bridge.setWebViewDelegate(self)
        registBridge(bridge)
        
        let (webURL, result) = checkUrl(url: model.url)
        if result {
            webView.load(URLRequest(url: webURL!))
        }
    }
}

extension EWebController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navTitle = self.navTitle != "" ? self.navTitle : webView.title ?? ""
    }
}

func checkUrl(url: String) -> (URL?, Bool) {
    guard let urlStr = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet(charactersIn:"").inverted), let webUrl = URL(string: urlStr) else {
        ELog("url不合法"+url)
        return (nil, false)
    }
    return (webUrl, true)
}
