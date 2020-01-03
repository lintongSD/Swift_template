//
//  EUpDateView.swift
//  appwork
//
//  Created by EBIZM2 on 2019/4/28.
//  Copyright © 2019 EBIZHZ1. All rights reserved.
//

import UIKit
import SwiftyJSON

class UpDateView: UIView {
    
    var model = APPLoadingModel() {
        didSet{
            versionLabel.text = model.update.vname
            contentTextView.text = model.update.content
        }
    }
    //是否是强制升级的标志位
    var isforceFlag = Bool(false) {
        didSet{
            afterBtn.isHidden = isforceFlag
            cancelBtn.isHidden = isforceFlag
            updateBtn.isHidden = !isforceFlag
        }
    }
    let upViewWidth: CGFloat = 258
    lazy var mainView: UIView = {   //渐变色
        let view = UIView(frame: CGRect(x: 0, y: 0, width: upViewWidth, height: 408))
        view.center = self.center
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7.0
        let topColr = UIColor.colorWithHexString(color: "FB866D")
        let bottomColr = UIColor.themeColor
        let gradientLayer = CAGradientLayer.gradientLayerPortrait(aColor:  topColr, bColor: bottomColr)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: upViewWidth, height: 408)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return view
    }()
    lazy var versionLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 84, width: upViewWidth, height: 35))
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var afterBtn: UIButton = {
        let btn = createBtn("升级", CGRect.init(x: 144, y: 359, width: 90, height: 34))
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 3
        btn.setTitleColor(.themeColor, for: .normal)
        btn.addTarget(self, action: #selector(self.go2upDateClick), for: .touchUpInside)
        return btn
    }()
    lazy var cancelBtn: UIButton = {
        let btn = createBtn("取消", CGRect.init(x: 24, y: 359, width: 90, height: 34))
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 3
        btn.setTitleColor(.themeColor, for: .normal)
        btn.addTarget(self, action: #selector(self.cancelBtnClick), for: .touchUpInside)
        return btn
    }()
    lazy var updateBtn: UIButton = {
        let btn = createBtn("立即更新", CGRect.init(x: 24, y: 359, width: upViewWidth-48, height: 34))
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 3
        btn.setTitleColor(.themeColor, for: .normal)
        btn.addTarget(self, action: #selector(self.go2upDateClick), for: .touchUpInside)
        return btn
    }()
    lazy var contentTextView: UITextView = {
        let textView = UITextView.init(frame: CGRect.init(x: 22, y: 248, width: upViewWidth-44, height: 95))
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.isEditable = false
        return textView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.addSubview(mainView)
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: upViewWidth, height: 44))
        titleLabel.text = "升级提示"
        titleLabel.textColor = .white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        mainView.addSubview(titleLabel)
        
        let line = UIImageView.init(frame: CGRect.init(x: 0, y: 44, width: upViewWidth, height: 1))
        line.backgroundColor = .white
        mainView.addSubview(line)
        
        let updateIcon = UIImageView.init(frame: CGRect.init(x: (upViewWidth - 135)/2, y: 122, width: 135, height: 114))
        updateIcon.image = UIImage.init(named: "icon_update")
        mainView.addSubview(updateIcon)
        
        let detailLabel = UILabel.init(frame: CGRect.init(x: 0, y: 52, width: upViewWidth, height: 35))
        detailLabel.text = "当前不是最新版本，请更新"
        detailLabel.numberOfLines = 0
        detailLabel.textColor = .white
        detailLabel.textAlignment = NSTextAlignment.center
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        mainView.addSubview(detailLabel)
        mainView.addSubview(versionLabel)
        
        mainView.addSubview(contentTextView)
        
        mainView.addSubview(cancelBtn)
        mainView.addSubview(afterBtn)
        mainView.addSubview(updateBtn)
        
        updateBtn.isHidden = true
        
    }
    @objc func cancelBtnClick() {
        self.removeFromSuperview()
    }
    @objc func go2upDateClick() {
#if DEBUG
        if model.update.aurl.count > 4 {
            if UIApplication.shared.canOpenURL(URL(string:model.update.aurl)!) {
                UIApplication.shared.openURL(URL(string: model.update.aurl)!)
                if !isforceFlag {
                    self.removeFromSuperview()
                }
            }
        } else {
            ToastTool.toast("暂无下载链接")
        }
#else
        if model.update.prdUrl.count > 4 {
            if UIApplication.shared.canOpenURL(URL(string:model.update.prdUrl)!) {
                UIApplication.shared.openURL(URL(string: model.update.prdUrl)!)
                if !isforceFlag {
                    self.removeFromSuperview()
                }
            }
        } else {
            ToastTool.toast("暂无下载链接")
        }
#endif
        
    }
    func createBtn(_ title: String, _ frame: CGRect) -> UIButton {
        let button = UIButton.init(frame: frame)
        button.layer.cornerRadius = 3
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.colorWithHexString(color: "4A90E2"), for: .normal)
        return button
    }
    
    //MARK: - 版本检查
    class func checkVersion() {
        
//        //  当前版本号
//        let currentVersion = Int(Md5.getCurrentVersion())!
//        //  最低版本号
//        let mvStr = ApiHelper.instance.appLoadingModel.update.mversion == "" ? "0" : ApiHelper.instance.appLoadingModel.update.mversion
//        let minVersion = Int(mvStr)!
//        //  线上最高版本号
//        let cversionStr = ApiHelper.instance.appLoadingModel.update.cversion == "" ? "0" :
//            ApiHelper.instance.appLoadingModel.update.cversion
//        let highVersion = Int(cversionStr)!
//        if currentVersion < minVersion { // 当前版本小于最低版本 弹强制更新
//            self.showUpdateView(ApiHelper.instance.appLoadingModel, true)
//        } else if currentVersion < highVersion {  //当前版本小于线上最高版本 提示更新
//            self.showUpdateView(ApiHelper.instance.appLoadingModel, false)
//        }
//
//        ELog("checkVersion版本检查：最低要求版本号\(mvStr),当前最新版本号\(cversionStr)")
    }
    
    //是否强制更新的view
    class func showUpdateView(_ model : APPLoadingModel,_ isForce:Bool) {
        let tipView = UpDateView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        tipView.model = model
        tipView.isforceFlag = isForce
        for view in mainWindow.subviews {
            if view is ADView {
                (view as! ADView).hiddenjumpBtn = isForce
            }
        }
        let rootView = UIApplication.shared.keyWindow
        rootView?.addSubview(tipView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CAGradientLayer {
    ///渐变色横向
    class func gradientLayerCross(aColor : UIColor, bColor : UIColor) -> CAGradientLayer {
        let layer = CAGradientLayer()
        let gradientColors = [aColor.cgColor,
                              bColor.cgColor]
        
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        //创建CAGradientLayer对象并设置参数
        layer.colors = gradientColors
        layer.locations = gradientLocations
        layer.masksToBounds = true
        layer.cornerRadius = 3
        //设置渲染的起始结束位置（横向渐变）
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        return layer
    }
    
    ///渐变色纵向
    class func gradientLayerPortrait(aColor : UIColor, bColor : UIColor) -> CAGradientLayer {
        let layer = CAGradientLayer()
        let gradientColors = [aColor.cgColor,
                              bColor.cgColor]
        
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        //创建CAGradientLayer对象并设置参数
        layer.colors = gradientColors
        layer.locations = gradientLocations
        layer.masksToBounds = true
        layer.cornerRadius = 3
        //设置渲染的起始结束位置（横向渐变）
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        return layer
    }
}
