//
//  FPSView.swift
//  Nanyuan-Swift
//
//  Created by haozhongliang on 2021/8/25.
//  Copyright © 2021 LT. All rights reserved.
//

import UIKit

class FPSView: UILabel {
    
    var timer: CADisplayLink!
    
    // 上次刷新时间
    var lastTimestamp: TimeInterval = 0
    var fpsCount: Double = 0
    
    final class func show() {
        let fps = FPSView(frame: .init(x: 0, y: 200, width: 80, height: 20))
        fps.backgroundColor = .green
        fps.alpha = 0.5
        fps.textAlignment = .center
        fps.font = .systemFont(ofSize: 14)
        fps.layer.cornerRadius = 4
        fps.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            mainWindow.addSubview(fps)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        timer = CADisplayLink(target: self, selector: #selector(displayLinkAction(link:)))
        timer.add(to: .current, forMode: .common)
        loadPanGesture()
    }
    
    @objc func displayLinkAction(link: CADisplayLink) {
        if lastTimestamp == 0 {
            lastTimestamp = link.timestamp
            return
        }
        fpsCount += 1
        
        let time = link.timestamp - lastTimestamp
        if time < 1 { return }
        lastTimestamp = link.timestamp
        
        let fps = fpsCount / time
        fpsCount = 0
        text = "FPS: " + String(format: "%.2f", fps)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 拖动，边缘吸附效果
extension FPSView {
    private func loadPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(moveView(pan:)))
        addGestureRecognizer(pan)
    }
    
    @objc func moveView(pan:UIPanGestureRecognizer)  {
        let point = pan.translation(in: self)
        center = CGPoint(x: center.x + point.x , y: center.y + point.y)
        pan.setTranslation(.zero, in: self)
        if pan.state == .ended {
            var x:CGFloat = 0
            let screenHeight = UIScreen.main.bounds.height
            let screenWidth = UIScreen.main.bounds.width
            let maxY = screenHeight - frame.height
            if center.x > screenWidth/2 {
                x = screenWidth - frame.width
            }
            var y = frame.minY
            y = y < 0 ? 0 : y
            y = y > maxY ? maxY:y
            UIView.animate(withDuration: 0.4) {
                self.frame = CGRect(x: x, y: y, width: self.frame.width, height: self.frame.height)
            }
        }
        
    }
}
