//
//  ADView.swift
//  project
//
//  Created by lintong on 2018/10/22.
//  Copyright © 2018年 lintong. All rights reserved.
//

import UIKit

class ADView: UIView {
    
    //跳过按钮的定时器
    lazy var timer: Timer = {
        return Timer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil , repeats: true)
    }()
    //定时器时间
    var countDownSec = 4
    
    var hiddenjumpBtn = false
    
    var model = AppLoadingModel()
    
    func layoutUI() {
        addSubview(vc.view)
        addSubview(adImageView)
        addSubview(jumpButton)
        
        NetworkTool.requestJSON(url: ApiManager.getBaseApiByName("appLoadingAPI"), method: .get, parameters: nil, success: { (json) in
            guard let model = json["content"].dictionaryObject, let appLoadingModel = AppLoadingModel.deserialize(from: model) else {
                self.invalidateView()
                return
            }
            self.model = appLoadingModel
            self.getAppLoadingInfoFinish()
            //版本检查
            UpDateView.checkVersion(appLoadingModel)
        }) { (error) in
            self.invalidateView()
        }
    }
    
    @objc func getAppLoadingInfoFinish() {
        let imageUrlStr = isiPhoneX ? model.flash.ximg : model.flash.img
        
        if imageUrlStr.isEmpty {
            invalidateView()
        } else {
            adImageView.sd_setImage(with:  URL.init(string:imageUrlStr)) { (image, error, type, url) in
                if error == nil {
                    RunLoop.current.add(self.timer, forMode: .default)
                }
            }
        }
    }
    
  
    
    @objc func adTarget() {
//        RouteTool.bridgeWith(model.flash.route)
        invalidateView()
    }
    
    
    @objc func countdown() {
        if !hiddenjumpBtn {
            jumpButton.isHidden = false
            countDownSec -= 1
            if (countDownSec > 0){
                let str = "跳过\(countDownSec)"
                jumpButton.setTitle(str, for: UIControl.State.normal)
            }else{
                invalidateView()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: mainWindow.bounds)
        layoutUI()
    }
    
    // 启动图占屏
    lazy var vc: UIViewController = {
        let vc = UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        vc.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return vc
    }()
    // 广告图
    lazy var adImageView: UIImageView = {
        let adImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-100))
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(adTarget))
        adImageView.isUserInteractionEnabled = true
        adImageView.addGestureRecognizer(tapGesture)
        adImageView.contentMode = .scaleAspectFill
        adImageView.clipsToBounds = true
        return adImageView
    }()
    // 跳过按钮
    lazy var jumpButton: UIButton = {
        let jumpButton = UIButton(frame: CGRect(x: screenWidth - 59, y: navigationHeight-36, width: 49, height: 36))
        jumpButton.alpha = 0.7
        jumpButton.isHidden = true
        jumpButton.layer.cornerRadius = 5
        jumpButton.layer.masksToBounds = true
        jumpButton.backgroundColor = UIColor.black
        jumpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        jumpButton.addTarget(self, action: #selector(invalidateView), for: .touchUpInside)
        return jumpButton
    }()
    
    @objc func invalidateView() {
        timer.invalidate()
        vc.view.removeFromSuperview()
        removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        ELog("广告页被销毁")
    }
}


