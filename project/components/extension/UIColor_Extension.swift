//
//  UIColor_Extension.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

//颜色扩展
extension UIColor{
    class var themeColor: UIColor {
        get {
            return UIColor.colorWithHexString(color: "007E3E")
        }
    }
    // controller背景色
    class var backgroundColor: UIColor {
        get {
            return UIColor.colorWithHexString(color: "F5F5F5")
        }
    }
    // 标题颜色
    class var titleColor: UIColor {
        get {
            return UIColor.colorWithHexString(color: "333333")
        }
    }
    // 详情颜色
    class var detailColor: UIColor {
        get {
            return UIColor.colorWithHexString(color: "999999")
        }
    }
    // 二级标题色
    class var subTitleColor: UIColor {
        get {
            return UIColor.colorWithHexString(color: "666666")
        }
    }
    class var lineColor: UIColor {
        get {
            return UIColor.colorWithHexString(color: "F3F5F8")
        }
    }
    
    class func colorWithHexString(color:String) -> UIColor{
        
        var cString = color.trimmingCharacters(in: .whitespaces)
        if cString.count < 6 {
            return UIColor.clear
        }
        if cString.hasPrefix("0X") {
            cString = String(cString.prefix(2))
        }
        if cString.hasPrefix("#") {
            cString = String(cString.prefix(1))
        }
        if cString.count != 6 {
            return UIColor.clear
        }
        
        let rStarIndex = cString.index(cString.startIndex, offsetBy: 0)
        let rEndIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString[rStarIndex..<rEndIndex]
        
        let gStarIndex = cString.index(cString.startIndex, offsetBy: 2)
        let gEndIndex = cString.index(cString.startIndex, offsetBy: 4)
        let gString = cString[gStarIndex..<gEndIndex]
        
        let bStarIndex = cString.index(cString.startIndex, offsetBy: 4)
        let bEndIndex = cString.index(cString.startIndex, offsetBy: 6)
        let bString = cString[bStarIndex..<bEndIndex]
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner.init(string: String(rString)).scanHexInt32(&r)
        Scanner.init(string: String(gString)).scanHexInt32(&g)
        Scanner.init(string: String(bString)).scanHexInt32(&b)
        
        return UIColor.init(red: CGFloat.init(r)/255.0, green: CGFloat.init(g)/255.0, blue: CGFloat.init(b)/255.0, alpha: 1)
        
    }
}

