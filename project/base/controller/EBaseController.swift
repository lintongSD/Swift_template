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
            self.navView.isHidden = false
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
        let classArr = [HomeController.self, LeftController.self, RightController.self, MineController.self]
        if classArr.contains(where: { $0 == self.classForCoder }) {
            leftButton.isHidden = true
        }
    }
    
    
    @objc func leftButtonSelect(){
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
        
        bridge.registerHandler("getToken") { (data, responseCallback) in
            if responseCallback != nil {
                responseCallback!(Storage.token)
            }
        }
    }
}
