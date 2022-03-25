//
//  EController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

typealias vcCallBack = ([String: Any]) -> Void

class EController: UIViewController {

    enum MaskType {
        case networkError
        case noData
    }
    var maskType: MaskType?
    
    var extra: [String: Any]?
    var callBack: vcCallBack?
    
    
    var navTitle = "" {
        didSet {
            navTitleLable.text = navTitle
        }
    }
    
    var navView = UIView()
    var leftButton = UIButton()
    var navTitleLable = UILabel()
    
    // pop手势是否可用
    var interactivePopDisabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        extendedLayoutIncludesOpaqueBars = true
        automaticallyAdjustsScrollViewInsets = true
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.isTranslucent = false
        
        setNavView()
        hiddenLeftBtn()
        
        addPopGesture()
        NotificationTool.observer(self, #selector(loginSuccess), .loginSuccess)
        
    }
    
    func setNavView() {
        navView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: navigationHeight))
        navView.backgroundColor = .themeColor
        
        leftButton = UIButton.init(frame: CGRect(x: 0, y: navigationHeight - 44, width: 44, height: 44))
        leftButton.setImage(UIImage.init(named: "backButtonIcon"), for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        leftButton.addTarget(self, action: #selector(leftButtonSelect), for: .touchUpInside)
        
        
        navTitleLable = UILabel.init(frame: CGRect(x: 90, y: navigationHeight - 44, width: screenWidth - 180, height: 44))
        navTitleLable.textColor = .white
        navTitleLable.textAlignment = .center
        
        navTitleLable.font = UIFont.systemFont(ofSize: 18)
        
        navView.addSubview(leftButton)
        navView.addSubview(navTitleLable)
        
        view.addSubview(navView)
    }
    
    func hiddenLeftBtn() {
        let classArr = [HomeController.self, LeftController.self, RightController.self, MineController.self]
        if classArr.contains(where: { $0 == classForCoder }) {
            leftButton.isHidden = true
        }
    }
    
    
    @objc func leftButtonSelect() {
        if navigationController == nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    func loadData() {
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ELog("--- 当前控制器 --- \(NSStringFromClass(type(of: self))) ---")
    }
    
    deinit {
        ELog("--- 被销毁 --- \(NSStringFromClass(type(of: self))) ---")
        NotificationCenter.default.removeObserver(self)
    }
    @objc func loginSuccess() {
        
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension EController: UIGestureRecognizerDelegate {
    private func addPopGesture() {
        guard let target = navigationController?.interactivePopGestureRecognizer?.delegate else { return }
        let panGesture = UIPanGestureRecognizer.init(target: target, action: Selector(("handleNavigationTransition:")))
        view.addGestureRecognizer(panGesture)
        
        panGesture.delegate = self
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 禁止返回手势
        if interactivePopDisabled { return false }
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}


extension EController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str: String!
        switch maskType {
        case .networkError:
            str = "网络连接失败"
        case .noData:
            str = "暂无数据"
        default:
            str = ""
        }
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)])
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        switch maskType {
        case .networkError:
            return UIImage(named: "picture_blank_wifi")
        case .noData:
            return UIImage(named: "blank_nothing")
        default:
            return UIImage()
        }
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        if maskType == .networkError {
            let attrs: [NSAttributedString.Key: Any] = [.font : UIFont.systemFont(ofSize: 14),
                                                        .foregroundColor : UIColor.themeColor]
            return NSAttributedString(string: "点击重试", attributes: attrs)
        } else {
            return NSAttributedString(string: "")
        }
    }
    
}
