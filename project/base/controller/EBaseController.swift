//
//  EBaseController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit
import SwiftyJSON

class EBaseController: UIViewController {

    var navTitle = "" {
        didSet {
            self.navTitleLable.text = self.navTitle
        }
    }
    
    var navView = UIView()
    var leftButton = UIButton()
    var navTitleLable = UILabel()
    
    // pop手势是否可用
    var interactivePopDisabled = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = .backgroundColor
        
        setNavView()
        hiddenLeftBtn()
        
        addPopGesture()
        
    }
    
    func setNavView() {
        self.navView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: navigationHeight))
        self.navView.backgroundColor = .themeColor
        
        self.leftButton = UIButton.init(frame: CGRect(x: 0, y: navigationHeight - 44, width: 44, height: 44))
        self.leftButton.setImage(UIImage.init(named: "backButtonIcon"), for: .normal)
        self.leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.leftButton.addTarget(self, action: #selector(self.leftButtonSelect), for: .touchUpInside)
        
        
        self.navTitleLable = UILabel.init(frame: CGRect(x: 90, y: navigationHeight - 44, width: screenWidth - 180, height: 44))
        self.navTitleLable.textColor = .white
        self.navTitleLable.textAlignment = .center
        
        self.navTitleLable.font = UIFont.systemFont(ofSize: 18)
        
        self.navView.addSubview(leftButton)
        self.navView.addSubview(navTitleLable)
        
        self.view.addSubview(navView)
    }
    
    func hiddenLeftBtn() {
        let classArr = [HomeController.self, ProductController.self, SpecialController.self, ChatController.self, MineController.self]
        if classArr.contains(where: { $0 == self.classForCoder }) {
            leftButton.isHidden = true
        }
    }
    
    
    @objc func leftButtonSelect() {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ELog("--- 当前控制器 --- \(NSStringFromClass(type(of: self))) ---")
    }
    
    deinit {
        ELog("--- 被销毁 --- \(NSStringFromClass(type(of: self))) ---")
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension EBaseController: UIGestureRecognizerDelegate {
    
    func addPopGesture() {
        guard let target = self.navigationController?.interactivePopGestureRecognizer?.delegate else { return }
        let panGesture = UIPanGestureRecognizer.init(target: target, action: Selector(("handleNavigationTransition:")))
        self.view.addGestureRecognizer(panGesture)
        
        panGesture.delegate = self
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 禁止返回手势
        if interactivePopDisabled { return false }
        return self.navigationController?.viewControllers.count ?? 0 > 1
    }
}


extension EBaseController {
    func registBridge(_ bridge: WebViewJavascriptBridge) {
        bridge.registerHandler("bridge") { (data, responBlock) in
            if JSONSerialization.isValidJSONObject(data!) {
                let json = JSON.init(data!)
                RouteTool.bridgeWith(json.rawString() ?? "")
            }
        }
        
        //获取token
        bridge.registerHandler("getToken") { (data, responBlock) in
            let tokenDic = ["token":Storage.token]
            let data = try! JSONSerialization.data(withJSONObject: tokenDic, options: [])
            let JSONString = String(data:data, encoding: .utf8)
            responBlock!(JSONString)
        }
        
        //扫码
        bridge.registerHandler("scanCallback") { (data, responBlock) in
            let scan = ScannningVC()
            scan.needBack = true
            scan.getScanResult { (str) in
                let result = str.addingPercentEncoding(withAllowedCharacters: NSCharacterSet(charactersIn:"").inverted)!
                let resDic:[String : Any] = ["result":result]
                let jsonStr = JSON(resDic).rawString()
                responBlock!(jsonStr)
            }
            RouteTool.currentNav.pushViewController(scan, animated: true)
        }
        
        bridge.registerHandler("callSystem") { (data, response) in
            guard let data = data else { return }
            var url: URL?
            let number = JSON(data)["number"].stringValue
            let system = JSON(data)["system"].stringValue
            switch system{
            case "tel":
                url = URL(string: "tel://\(number)")
            case "sms":
                url = URL(string: "sms://\(number)")
            default:
                print("")
            }
            if url != nil {
                if UIApplication.shared.canOpenURL(url!) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url!)
                    }
                }
            }
        }
        bridge.registerHandler("login") { (data, response) in
            RouteTool.pushLoginVC()
        }
        
    }
}
