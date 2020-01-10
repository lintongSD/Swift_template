//
//  EWebController.swift
//  project
//
//  Created by ebiz on 2020/1/9.
//  Copyright © 2020 lintong. All rights reserved.
//

import WebKit

class EWebController: EBaseController, WKNavigationDelegate {
    
    var url = ""
    var webView = EBaseWebView()
    var isFirstLogin = true
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = CGRect(x: 0, y: navigationHeight, width: screenWidth, height: screenHeight-navigationHeight)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        let (webURL, result) = checkUrl(url: self.url)
        if result {
            webView.load(URLRequest(url: webURL!))
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
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
