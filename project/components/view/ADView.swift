//
//  ADView.swift
//  project
//
//  Created by EBIZHZ1 on 2018/10/22.
//  Copyright © 2018年 EBIZHZ1. All rights reserved.
//

import UIKit

class ADView: UIView {
    
    var vc: UIViewController!
    
    //跳过按钮的定时器
    var timer = Timer()
    //定时器时间
    var countDownSec = Int()
    
    let adDeleteButton = UIButton()
    let adImageView = UIImageView()
    var hiddenjumpBtn = false //不显示跳过按钮-不能隐藏闪屏
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUI(){
        self.vc = UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        let mainWidow = UIApplication.shared.keyWindow
        vc.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        mainWidow?.addSubview(vc.view)
        self.window?.bringSubviewToFront(vc.view)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.adTarget))
        self.adImageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-150)
        self.adImageView.isUserInteractionEnabled = true
        self.adImageView.addGestureRecognizer(tapGesture)
        self.adImageView.contentMode = .scaleAspectFill
        self.adImageView.clipsToBounds = true
        self.addSubview(self.adImageView)
        
        self.adDeleteButton.frame = CGRect(x: screenWidth - 59, y: navigationHeight-36, width: 49, height: 36)
        self.adDeleteButton.backgroundColor = UIColor.black
        self.adDeleteButton.alpha = 0.7
        self.adDeleteButton.isHidden = true
        self.adDeleteButton.layer.masksToBounds = true
        self.adDeleteButton.layer.cornerRadius = 5
        self.adDeleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.adDeleteButton.addTarget(self, action: #selector(removeSelfFromSuperview), for: .touchUpInside)
        self.addSubview(adDeleteButton)
        
        ELog("开始请求apploadingAPI")
//        EApi.instance.getWithSign(EApi.instance.getConfigApiByName("welcomeAPI"), [:], success: { (json) in
//            guard let model = JSON(json)["content"]["content"].dictionaryObject else {
//                self.removeSelfFromSuperview()
//                return
//            }
//            ApiHelper.instance.appLoadingModel = EAPPLoadingModel(model as NSDictionary)
//            ELog("请求结束apploadingAPI")
//            self.getAppLoadingInfoFinish()
//            //版本检查
//            EUpDateView.checkWelcomeVersion()
//        }) { (error) in
//            self.removeSelfFromSuperview()
//        }
    }
    
    @objc func getAppLoadingInfoFinish(){
        var imageUrlStr = ""
        
        if isiPhoneX {
//            imageUrlStr = ApiHelper.instance.appLoadingModel.welImgList_showing[0].imgHrefExt1
        } else {
//            imageUrlStr = ApiHelper.instance.appLoadingModel.welImgList_showing[0].imgHref
        }
        
        if imageUrlStr.isEmpty {
            self.removeSelfFromSuperview()
        } else {
//            self.adImageView.sd_setImage(with:  URL.init(string:imageUrlStr)) { (image, error, type, url) in
//                if error == nil {
//                    let time = Int(ApiHelper.instance.appLoadingModel.welImgList_showing[0].showTime) ?? 3000
//                    self.countDownSec = (time/1000) + 1
//                    if time == 1 {
//                        self.removeSelfFromSuperview()
//                        return
//                    }
//                    self.timer = Timer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil , repeats: true)
//                    RunLoop.current.add(self.timer, forMode: .default)
//                }
//            }
        }
    }
    
  
    
    @objc func adTarget() {
//        Router.instance.bridgeWithRouteModel(ApiHelper.instance.appLoadingModel.welImgList_showing[0].route)
        self.removeSelfFromSuperview()
    }
    
    
    @objc func countdown(){
        if !self.hiddenjumpBtn {
            self.adDeleteButton.isHidden = false
            countDownSec -= 1
            if (countDownSec > 0){
                let str = "跳过\(countDownSec)"
                self.adDeleteButton.setTitle(str, for: UIControl.State.normal)
            }else{
                self.removeSelfFromSuperview()
            }
        }
    }
    
    @objc func removeSelfFromSuperview(){
        self.timer.invalidate()
        self.removeFromSuperview()
        if self.vc != nil {
            self.vc.view.removeFromSuperview()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


