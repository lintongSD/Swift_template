//
//  EDevice.swift
//  project
//
//  Created by EBIZHZ1 on 2018/10/18.
//  Copyright © 2018年 EBIZHZ1. All rights reserved.
//

import UIKit


let mainWindow = UIApplication.shared.keyWindow!

//MARK: 设备信息

//是不是iphoneX
let isiPhoneX = UIApplication.shared.statusBarFrame.height > 30 ? true : false
//设备宽高
let screenHeight = UIScreen.main.bounds.height

let screenWidth  = UIScreen.main.bounds.width

let statusBarHeight = UIApplication.shared.statusBarFrame.size.height

//导航栏高度
let navigationHeight: CGFloat = isiPhoneX ? 88 : 64

//tabbar高度
let tabbarHeight: CGFloat = isiPhoneX ? 83 : 49







//声明一个debug模式下打印数据的公共方法（可在其他类中直接调用;CUSTOMDEBUG是自定义的宏，只在debug模式下有效： Build Setting->Swift Compiler -> Custom Flags -> Debug
func ELog<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm:ss"
    let date = formatter.string(from: Date())
    let s = "[\(fileName) 时间:\(date) line:\(lineNumber)]- \(message)"
    print(s)
#endif
}


