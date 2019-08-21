//
//  EBaseController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

class EBaseController: UIViewController {

    var navTitle:String = "" {
        didSet {
            self.navTitleLable.text = self.navTitle
            self.navView.isHidden = false
        }
    }
    
    var navView = UIView()
    var leftButton = UIButton()
    var navTitleLable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.backgroundColor
        
        setNavView()
        hiddenLeftBtn()
        
    }
    
    func setNavView() {
        self.navView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: navigationHeight))
        self.navView.backgroundColor = UIColor.themeColor
        
        self.leftButton = UIButton.init(frame: CGRect(x: 0, y: navigationHeight - 44, width: 44, height: 44))
        self.leftButton.setImage(UIImage.init(named: "backButtonIcon"), for: .normal)
        self.leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.leftButton.addTarget(self, action: #selector(self.leftButtonSelect), for: .touchUpInside)
        
        
        self.navTitleLable = UILabel.init(frame: CGRect(x: 90, y: navigationHeight - 44, width: screenWidth - 180, height: 44))
        self.navTitleLable.textColor = UIColor.white
        self.navTitleLable.textAlignment = .center
        
        self.navTitleLable.font = UIFont(name: "PingFangSC-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
        
        self.navView.addSubview(leftButton)
        self.navView.addSubview(self.navTitleLable)
        
        self.view.addSubview(self.navView)
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
