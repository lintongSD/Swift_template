//
//  ScanningView.swift
//
//
//  Created by liyingnan on 2017/6/13.
//  Copyright © 2017年 carme. All rights reserved.
//

import UIKit

class ScanningView: UIView {

    
    //屏幕扫描区域视图
    let barcodeView = UIImageView(frame: CGRect(x: 60, y: 0, width: screenWidth  - 120, height: screenWidth  - 120))
    //扫描线
    let scanLine = UIImageView()
    
    //var scanning : String!
    var timer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        barcodeView.center.y = screenHeight / 2 - 64
        barcodeView.image = UIImage(named: "scanningImageView")
        self.addSubview(barcodeView)
        //设置扫描线
        scanLine.image = UIImage(named: "scanningLine")
        //添加扫描线图层
        barcodeView.addSubview(scanLine)
        self.createBackGroundView()
        timer = Timer(timeInterval: 2, target: self, selector: #selector(self.moveScannerLayer), userInfo: nil , repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }
    
    func  createBackGroundView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0,  width: screenWidth, height:barcodeView.frame.minY))
        let bottomView = UIView(frame: CGRect(x: 0, y:barcodeView.frame.maxY, width: screenWidth, height:300))
        
        let leftView = UIView(frame: CGRect(x: 0, y: barcodeView.frame.minY, width: 60, height:barcodeView.lt_height))
        let rightView = UIView(frame: CGRect(x: 60+barcodeView.lt_width, y:barcodeView.frame.minY, width: 60, height:barcodeView.lt_height))
        let color = UIColor.colorWithHexString(color: "111111").withAlphaComponent(0.3)
        topView.backgroundColor     = color
        bottomView.backgroundColor  = color
        leftView.backgroundColor    = color
        rightView.backgroundColor   = color
        
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: screenWidth, height: 21))
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "请将扫描框对准二维码即可"
        self.addSubview(label)

        bottomView.addSubview(label)

        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(leftView)
        self.addSubview(rightView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //让扫描线滚动
     @objc func moveScannerLayer() {
        scanLine.frame = CGRect(x: 10, y: 10, width: self.barcodeView.frame.size.width - 20, height: 2)
        UIView.animate(withDuration: 2.1) {
            self.scanLine.frame = CGRect(x: 10, y: self.barcodeView.lt_height - 10, width: self.barcodeView.lt_width - 20, height: 2)
        }
    }

}
