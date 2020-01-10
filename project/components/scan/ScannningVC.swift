//
//  ScannningVC.swift
//  
//
//  Created by liyingnan on 2017/6/13.
//  Copyright © 2017年 carme. All rights reserved.
//

import UIKit
import AVFoundation
typealias scaningResultBlock = (_ res: String)->Void


class ScannningVC: EBaseController ,AVCaptureMetadataOutputObjectsDelegate {
    
    //相机显示视图
    let cameraView = ScanningView(frame: CGRect(x: 0, y: navigationHeight, width: screenWidth, height: screenHeight - navigationHeight))
    var captureSession: AVCaptureSession!
    
    var resBolck : scaningResultBlock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle = "扫描二维码"
        self.view.addSubview(cameraView)
        
        captureSession = AVCaptureSession()
        self.view.backgroundColor = UIColor.black
        DispatchQueue.main.async {
            let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
            var input :AVCaptureDeviceInput
            //创建媒体数据输出流
            let output = AVCaptureMetadataOutput()
            //捕捉异常
            do {
                print(captureDevice?.isFocusPointOfInterestSupported ?? false,"=======isFocusPointOfInterestSupported")
                print(captureDevice?.isFocusModeSupported(.autoFocus) ?? false,"=======autoFocus")
                //创建输入流
                input = try AVCaptureDeviceInput.init(device: captureDevice!)
                //把输入流添加到会话
                self.captureSession.addInput(input)
                
                //把输出流添加到会话
                self.captureSession.addOutput(output)
            } catch {
                print("异常")
                return
            }
            
            //设置输出流的代理
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //设置输出媒体的数据类型
            output.metadataObjectTypes = (NSArray(array: [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code128]) as! [AVMetadataObject.ObjectType])
            //创建预览图层
            let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            //设置预览图层的填充方式
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            //设置预览图层的frame
            videoPreviewLayer.frame = self.cameraView.bounds
            //将预览图层添加到预览视图上
            self.cameraView.layer.insertSublayer(videoPreviewLayer, at: 0)
            //设置扫描范围
            output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            self.captureSession.stopRunning()
            DispatchQueue.main.async {
                self.getResultStr(metaData.stringValue!) //扫出来的url请求接口.
            }
        }
    }
    
    func getResultStr(_ str: String) {
       ELog("二维码扫描结果为\(str)")
        if self.resBolck != nil {
            self.resBolck(str)
        }
        
        if str.starts(with: "http") {
            RouteTool.bridgeWith("{\"flag\":\"h5\",\"extra\":{\"url\":\"\(str)\"}}")
        } else {
            ToastTool.toast("扫描结果为：\(str)")
        }
    }
    
    func getScanResult(_ res : @escaping scaningResultBlock) {
        self.resBolck = res
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeFromParent()
    }

    
    
}
